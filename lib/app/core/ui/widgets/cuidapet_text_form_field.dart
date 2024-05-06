import 'package:flutter/material.dart';

class CuidapetTextFormField extends StatelessWidget {
  CuidapetTextFormField(
      {super.key,
      required this.labelText,
      this.obscureText = false,
      this.controller,
      this.validator})
      : _obscureTextVN = ValueNotifier<bool>(obscureText);
  final String labelText;
  final bool obscureText;
  final ValueNotifier<bool> _obscureTextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _obscureTextVN,
        builder: (_, obscureTextValue, child) {
          return TextFormField(
            controller: controller,
            validator: validator,
            obscureText: _obscureTextVN.value,
            decoration: InputDecoration(
                labelText: labelText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                suffixIcon: obscureText
                    ? IconButton(
                        onPressed: () {
                          _obscureTextVN.value = !_obscureTextVN.value;
                        },
                        icon: Icon(obscureTextValue
                            ? Icons.lock_outline
                            : Icons.lock_open_outlined))
                    : null),
          );
        });
  }
}
