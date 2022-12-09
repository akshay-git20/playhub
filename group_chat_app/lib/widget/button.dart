import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Button extends StatelessWidget {
  final Color bcolor;
  final VoidCallback onpressd;
  final String buttonname;
  const Button({
    Key? key,
    required this.bcolor,
    required this.onpressd,
    required this.buttonname,
    required this.controller,
  }) : super(key: key);

  final AnimationController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: bcolor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onpressd,
          height: 42.0,
          child: Text(
            buttonname,
            textScaleFactor: controller==null ? 1: controller!.value,
          ),
        ).w(controller==null ? 500:controller!.value * 500),
      ),
    );
  }
}
