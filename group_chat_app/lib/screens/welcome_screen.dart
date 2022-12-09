// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:group_chat_app/screens/login_screen.dart';
import 'package:group_chat_app/screens/registration_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widget/button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = "/welcome";
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animationn;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    animationn =
        ColorTween(begin: Colors.white, end: Colors.blue).animate(controller!);
    controller!.forward();
    controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF101010),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/sportso.jpg"), fit: BoxFit.fill)),
        constraints: BoxConstraints.expand(),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 200,
            ),
            Text(
              "PlayHub",
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 45.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            Button(
              controller: null,
              bcolor: Colors.lightBlueAccent,
              buttonname: "Log In",
              onpressd: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ).px(22),
            Button(
                controller: null,
                bcolor: Colors.blueAccent,
                buttonname: "Register",
                onpressd: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                }).px(22)
          ],
        ),
      ),
    );
  }
}
