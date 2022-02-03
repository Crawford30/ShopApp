import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _confirmPasswordTextController =
      TextEditingController();
  late String gender;
  String groupValue = "male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/back.jpg',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.4),
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 120.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.4),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Full Name",
                              icon: Icon(Icons.person_outline),
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "The name field can not be empty";
                              }

                              return null;
                            },
                            keyboardType: TextInputType.text,
                            controller: _nameTextController,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  "Male",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(color: Colors.black54),
                                ),
                                trailing: Radio(
                                    value: "male",
                                    groupValue: groupValue,
                                    onChanged: (e) => valueChanged(e)),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  "Female",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(color: Colors.black54),
                                ),
                                trailing: Radio(
                                    value: "female",
                                    groupValue: groupValue,
                                    onChanged: (e) => valueChanged(e)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.4),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "Email",
                                icon: Icon(Icons.email_outlined),
                                border: InputBorder.none),
                            validator: (value) {
                              if (value!.isEmpty) {
                                String pattern =
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                RegExp regExp = RegExp(pattern);
                                if (!regExp.hasMatch(value!)) {
                                  return "Please make sure your email address is valid";
                                } else {
                                  return null;
                                }
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailTextController,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.4),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "Password",
                                icon: Icon(Icons.lock_outline),
                                border: InputBorder.none),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "The password field can not be empty";
                              } else if (value.length < 6) {
                                return "Password has to be at least 6 characters long";
                              }

                              return null;
                            },
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passwordTextController,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.4),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "Confirm Password",
                                icon: Icon(Icons.lock_outline),
                                border: InputBorder.none),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "The password field can not be empty";
                              } else if (value.length < 6) {
                                return "Password has to be at least 6 characters long";
                              }

                              return null;
                            },
                            keyboardType: TextInputType.visiblePassword,
                            controller: _confirmPasswordTextController,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.red.shade700,
                        elevation: 0.0,
                        child: MaterialButton(
                          onPressed: () {},
                          minWidth: MediaQuery.of(context).size.width,
                          child: Text(
                            "Sign Up",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
    );
  }

  valueChanged(e) {
    setState(() {
      if (e == "male") {
        groupValue = e;
      } else if (e == "female") {
        groupValue = e;
      }
    });
  }
}
