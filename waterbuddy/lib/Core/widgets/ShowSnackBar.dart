import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String massege) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(massege)));
}
