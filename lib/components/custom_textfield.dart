import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final Color baseColor;
  final String? Function(String?)? validator;
  final bool? obsecureText;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.text,
      required this.baseColor,
      this.validator,
      this.obsecureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecureText == null ? false : true,
      validator: validator,
      controller: controller,
      style: TextStyle(color: baseColor),
      cursorColor: baseColor,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 229, 9, 20),
              width: 1,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 229, 9, 20),
              width: 2,
            )),
        labelText: text,
        labelStyle: TextStyle(color: baseColor),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 229, 9, 20),
              width: 1,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: baseColor, width: 0.3)),
      ),
    );
  }
}
