import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class MyTextField extends StatelessWidget {
  MyTextField({
    super.key,
    required this.controller,
    required this.lableText,
    required this.percentIcon,
    this.onChanged,
  });

  final String lableText;
  final TextEditingController controller;
  void Function(String value)? onChanged;
  bool percentIcon = false;
  static final RegExp numberRegExp = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]');
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        // if (value!.trim().isEmpty) {
        //   return "الحق فارغ";
        // }
        // if (validate.isNumeric(value)) {
        //   return "أدخل أرقاماً فقط";
        // }
      },
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      controller: controller,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        labelText: lableText,
        labelStyle: const TextStyle(
          fontSize: 15,
          color: Colors.black45,
        ),
        prefixText: percentIcon ? "%" : " ",
      ),
    );
  }
}
