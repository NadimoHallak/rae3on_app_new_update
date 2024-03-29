import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.lableText,
  });

  final String lableText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        labelText: lableText,
        labelStyle: const TextStyle(
          fontSize: 15,
          color: Colors.black45,
        ),
        suffixIcon: const Icon(
          Icons.delete,
          // size: 25,
          color: Colors.red,
        ),
      ),
    );
  }
}
