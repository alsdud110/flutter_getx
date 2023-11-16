import 'package:flutter/material.dart';

class CustomTextArea extends StatelessWidget {
  final String hint;
  final funcValidator;
  final controller;

  const CustomTextArea(
      {super.key,
      required this.hint,
      required this.funcValidator,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        maxLines: 10,
        validator: funcValidator,
        decoration: InputDecoration(
          hintText: "Enter $hint",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}
