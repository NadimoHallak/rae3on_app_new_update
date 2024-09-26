import 'package:flutter/material.dart';

class MyAlertDialog extends StatefulWidget {
  MyAlertDialog({
    super.key,
    required this.controller,
    required this.onCansle,
    required this.onDone,
    required this.title,
    required this.hint,
    
  });
  void Function() onCansle;
  void Function() onDone;
  final String title;
  final String hint;
  final TextEditingController controller;
  

  @override
  State<MyAlertDialog> createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      backgroundColor: Colors.white,
      title: Text(
        widget.title,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.start,
      ),
      content: TextFormField(
        
        validator: (String? value) {
          if (value!.trim().isEmpty) {
            return "إملأ الحقل";
          }
        },
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.center,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.end,
        decoration: InputDecoration(hintText: widget.hint),
      ),
      actions: [
        TextButton(
          onPressed: widget.onCansle,
          child: Text(
            "تراجع",
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.red[600]),
          ),
        ),
        TextButton(
          onPressed: widget.onDone,
          child: const Text(
            "أضف",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
