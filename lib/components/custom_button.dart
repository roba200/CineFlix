import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Function()? onPressed;
  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      child: Text(
        widget.text,
        style: TextStyle(
            color: Color.fromARGB(255, 252, 249, 255),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 229, 9, 20),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(10))),
    );
  }
}
