import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton2 extends StatelessWidget {
  CustomButton2({super.key, required this.text, this.onTap});

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
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue)),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(fontSize: 20, color: Colors.blue),
        )),
      ),
    );
  }
}
