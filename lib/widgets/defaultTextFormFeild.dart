import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final IconData icon;
  final TextInputType? inputType;
  final FormFieldValidator<String> validate;
  final void Function()? onTap;
  bool readOnly ;
  DefaultTextFormField(
      {required this.controller,
      required this.title,
      required this.validate,
      required this.icon,
        this.inputType = TextInputType.text,
      this.onTap,
         this.readOnly = false
      });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12),
      child: TextFormField(
        readOnly: readOnly,
        controller: controller,
        validator: validate,
        onTap: onTap,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: title,
          prefixIcon: Icon(icon),
        ),
        keyboardType: inputType,
      ),
    );
  }
}
