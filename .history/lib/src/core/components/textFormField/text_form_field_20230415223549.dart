import 'package:fittrack/src/core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';
import 'package:sizer/sizer.dart';

import '../../base/singleton/base_singleton.dart';
import '../../init/utils/typedefs.dart';
import '../text/custom_text.dart';

class TextFormFieldWidget extends StatelessWidget with BaseSingleton {
  const TextFormFieldWidget({
    super.key,
    this.hintText,
    this.onChanged,
    this.onSaved,
    this.controller,
    this.validator,
    this.isPassword = false,
  });

  final String? hintText;
  final Function? onSaved;
  final Function? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: colors.mainColor.withOpacity(.3),
        hintStyle: GoogleFonts.inter(
          color: Colors.black,
        ),
        border: OutlineInputBorder(
            borderRadius: context.normalBorderRadius,
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: context.normalBorderRadius,
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: context.normalBorderRadius,
            borderSide: BorderSide.none),
        errorBorder: OutlineInputBorder(
            borderRadius: context.normalBorderRadius,
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
