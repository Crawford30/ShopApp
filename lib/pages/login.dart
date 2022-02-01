import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late SharedPreferences preferences;
  bool loading = false;
  bool isLoggedIn = false;

  @override
  void initState() {
    // Calls the initial state of the class
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    //=https://stackoverflow.com/questions/54445610/the-method-signinwithgoogle-isnt-defined-for-the-class-firebaseauth

    //====Set State===
    setState(() {
      loading = true;
    });
    //========We assigning the instance of the shared preferences. await is a future method.(Hold on until it gets the value from the server)
    preferences = await SharedPreferences.getInstance();

    //Check if the user is signed in or not
    isLoggedIn = await googleSignIn.isSignedIn();

    //===If its true
    if (isLoggedIn) {
      //===With push replacement, the user doesnt have the ability to hit the back button to go back to the previous screen(login in scrrent)
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }

    //===Set state of loading because the user is logged in
    setState(() {
      loading = false;
    });
  }

  //======If not logged in===
  Future handleSignIn() async {
    //await Firebase.initializeApp();
    preferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });

    //======Create google sign in account===

    GoogleSignInAccount? googleUser =
        await googleSignIn.signIn(); //sign the user in

    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser!.authentication; //authenticate the user

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    // FirebaseUser firebaseUser = await firebaseAuth.signInWithGoogle(
    //     accessToken: googleSignInAuthentication.accessToken,
    //     idToken: googleSignInAuthentication.idToken);

    UserCredential authResult =
        await firebaseAuth.signInWithCredential(credential);

    if (authResult.user != null) {
      //===look for the user if the firebase id is equal to the uid
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection("users")
          .where("id", isEqualTo: authResult.user?.uid)
          .get();

      final List<DocumentSnapshot> documents = result.docs;

      //====If the user doesnt exist on our collection
      if (documents.length == 0) {
        //insert the user to out collection
        FirebaseFirestore.instance
            .collection("users")
            .doc(authResult.user?.uid)
            .set({
          "id": authResult.user!.uid,
          "username": authResult.user!.displayName,
          "profilePicture": authResult.user!.photoURL
        });

        //====Save results to shared preferences===
        await preferences.setString("id", authResult.user!.uid);
        await preferences.setString(
            "username", authResult.user!.displayName.toString());
        await preferences.setString(
            "photourl", authResult.user!.photoURL.toString());
      } else {
        //====If the user does exist, take the data from documents and save to sharedpreferences===
        await preferences.setString("id", documents[0]['id']);
        await preferences.setString("username", documents[0]['username']);
        await preferences.setString("photourl", documents[0]['photourl']);

        //===Show toast if successfully done
        Fluttertoast.showToast(msg: "Login was successful");

        //===Set loading state
        setState(() {
          loading = false;
        });

        //===Go back to homepage===

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    } else {
      Fluttertoast.showToast(msg: "Login failed :(");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/back.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "images/logo.png",
              width: 150.0,
              height: 150.0,
            ),
          ),
          Visibility(
            visible: loading ?? true,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.9),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.red),
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 12.0, right: 12.0, top: 8.0, bottom: 8.0),
          child: FlatButton(
            color: Colors.red.shade900,
            onPressed: () {
              handleSignIn();
            },
            child: Text(
              "Sign in/Sign up with google",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
