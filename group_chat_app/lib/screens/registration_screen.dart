// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group_chat_app/constants.dart';
import 'package:group_chat_app/screens/chat_screen.dart';
import 'package:group_chat_app/widget/button.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "/registeration";
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  bool showspinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'hero',
              child: SizedBox(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration:
                  ktextfeilddeco.copyWith(hintText: 'Enter your email'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration: ktextfeilddeco,
            ),
            SizedBox(
              height: 24.0,
            ),
            Button(
              controller: null,
              bcolor: Colors.blueAccent,
              buttonname: "Register",
              onpressd: () async {
                try {
                  final newuser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  Navigator.pushNamed(context, ChatScreen.id);
                } catch (e) {
                  print(e.toString());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
