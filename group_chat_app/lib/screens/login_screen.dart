// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:group_chat_app/screens/chat_screen.dart';

import '../widget/button.dart';

class LoginScreen extends StatefulWidget {
  static String id = "/loginscreen";
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  bool showspiner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF101010),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
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
              decoration: ktextfeilddeco.copyWith(hintText: 'Enter your email'),
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
                decoration: ktextfeilddeco),
            SizedBox(
              height: 24.0,
            ),
            Button(
              controller: null,
              bcolor: Colors.lightBlueAccent,
              buttonname: "Log In",
              onpressd: (() async {
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  Navigator.pushNamed(context, ChatScreen.id);
                } catch (e) {
                  print(e.toString());
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
