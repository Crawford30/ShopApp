import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

//====My Own imports
import './pages/login.dart';

void main() async {
  //https://stackoverflow.com/questions/65572086/no-firebase-app-has-been-created-call-firebase-initializeapp
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.red.shade900),
    home: Login(),
  ));
}
