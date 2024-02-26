import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextfield extends StatelessWidget {
  CustomTextfield(
      {this.label,
      this.hintText,
      this.obscureText,
      this.onChanged,
      this.validator,
      this.controller,
      this.focusNode,
      this.onEditingComplete,
      this.textInputAction});

  String? label;
  String? hintText;
  bool? obscureText;
  Function(String)? onChanged;
  String? Function(String?)? validator;
  TextEditingController? controller;
  FocusNode? focusNode;
  TextInputAction? textInputAction;

  void Function()? onEditingComplete;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onEditingComplete: onEditingComplete,
      focusNode: focusNode,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      textInputAction: textInputAction,
      style: const TextStyle(color: Colors.black, fontSize: 18, height: 1),
      obscureText: obscureText == null ? false : true,
      decoration: InputDecoration(
          focusColor: Colors.grey,
          fillColor: Colors.grey,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey)),
    );
  }
}
