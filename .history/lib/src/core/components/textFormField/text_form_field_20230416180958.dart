import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../base/singleton/base_singleton.dart';

class TextFormFieldWidget extends StatelessWidget with BaseSingleton {
  const TextFormFieldWidget({
    super.key,
    this.hintText,
    this.onChanged,
    this.onSaved,
    this.controller,
    this.validator,
    this.isPassword = false,
    this.initialValue,
    this.textInputType,
  });

  final String? hintText;
  final Function? onSaved;
  final Function? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? isPassword;
  final String? initialValue;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: colors.mainColor.withOpacity(.3),
        hintStyle: GoogleFonts.inter(
          color: Colors.black,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Colors.red)),
      ),
      obscureText: isPassword ?? false,
      onSaved: (value) {
        onSaved != null ? onSaved!(value) : null;
      },
      onChanged: (value) {
        onChanged != null ? onChanged!(value) : null;
      },
      cursorColor: colors.mainColor,
      validator: validator,
      controller: controller,
    );
  }
}
