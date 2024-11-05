import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  TextEditingController textEditingController;
  String label;
  final String? Function(String?)? formFieldValidator;

  AuthTextFormField(
      {required this.textEditingController,
      required this.label,
      required this.formFieldValidator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: formFieldValidator,
      controller: textEditingController,
      decoration: InputDecoration(labelText: label),
    );
  }
}
