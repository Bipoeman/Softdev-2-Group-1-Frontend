import 'package:flutter/material.dart';

Widget textField({
  required String labelText,
  required BuildContext context,
  String? Function(String?)? validator,
  TextEditingController? controller,
  int? maxLength,
  Icon? icon,
  bool? obscureText,
  TextInputType? inputType,
  bool? readOnly = false,
  bool? enabled = true,
  void Function(String)? onChanged,
  void Function()? onTap,
  void Function(PointerDownEvent)? onTapOutside,
  void Function()? onEditingComplete,
  void Function(String)? onFieldSubmitted,
  void Function(String?)? onSaved,
}) {
  ThemeData theme = Theme.of(context);
  return Container(
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
    child: TextFormField(
      enabled: enabled ?? true,
      readOnly: readOnly ?? false,
      maxLength: maxLength,
      controller: controller,
      validator: validator,
      keyboardType: inputType,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        counterText: "",
        isDense: true,
        fillColor: theme.colorScheme.background.withOpacity(0.8),
        filled: true,
        labelStyle:
            TextStyle(color: theme.colorScheme.onBackground.withOpacity(0.5)),
        contentPadding: const EdgeInsets.fromLTRB(30, 0, 5, 0),
        labelText: labelText,
        prefixIconColor: theme.colorScheme.onBackground,
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
      maxLines: 1,
    ),
  );
}
