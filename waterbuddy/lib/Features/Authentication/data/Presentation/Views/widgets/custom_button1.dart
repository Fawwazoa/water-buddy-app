import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton1 extends StatelessWidget {
  CustomButton1({super.key, required this.text, this.onTap});

  String text;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 900,
        height: 50,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 62, 150, 223),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        )),
      ),
    );
  }
}
