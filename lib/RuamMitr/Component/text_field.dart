import 'package:flutter/material.dart';

TextFormField textField({
  required String labelText,
  required Color fillColor,
  Icon? icon,
  bool? obscureText,
  TextInputType? inputType,
  void Function(String)? onChanged,
  void Function()? onTap,
  void Function(PointerDownEvent)? onTapOutside,
  void Function()? onEditingComplete,
  void Function(String)? onFieldSubmitted,
  void Function(String?)? onSaved,
}) {
  return TextFormField(
    keyboardType: inputType,
    obscureText: obscureText ?? false,
    decoration: InputDecoration(
      fillColor: fillColor,
      filled: true,
      labelStyle: TextStyle(color: Colors.grey[400]),
      contentPadding: const EdgeInsets.fromLTRB(30, 0, 5, 0),
      labelText: labelText,
      prefixIconColor: Colors.white,
      prefixIcon: icon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: BorderSide.none,
      ),
    ),
    onChanged: onChanged,
    onTap: onTap,
    onTapOutside: onTapOutside,
    onEditingComplete: onEditingComplete,
    onFieldSubmitted: onFieldSubmitted,
    onSaved: onSaved,
  );
}
