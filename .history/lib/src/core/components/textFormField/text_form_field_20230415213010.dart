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
  final int maxLines;
  final bool isPassword;
  final String hintText;
  final Color? hintColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? title;
  final Function? onChange;
  final bool autofocus;
  final double fontSize;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onSubmitted;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatter;
  final Function? onSaved;

  const TextFormFieldWidget(
      {Key? key,
      this.maxLines = 1,
      this.isPassword = false,
      this.hintText = "",
      this.hintColor,
      this.onChange,
      this.autofocus = false,
      this.controller,
      this.textInputType = TextInputType.text,
      this.textInputAction,
      this.validator,
      this.suffixIcon,
      this.prefixIcon,
      this.title,
      this.fontSize = 9,
      this.initialValue,
      this.onSubmitted,
      this.inputFormatter,
      this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        2.h.ph,
        title != null
            ? CustomText(
                "$title",
                textStyle: context.textTheme.displayLarge,
              )
            : const SizedBox.shrink(),
        1.h.ph,
        TextFormField(
          maxLines: maxLines,
          controller: controller,
          onChanged: (value) {
            if (onChange != null) {
              onChange!(value);
            }
          },
          autofocus: autofocus,
          textInputAction: textInputAction,
          onFieldSubmitted: onSubmitted,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: textInputType,
          obscureText: isPassword,
          inputFormatters: inputFormatter,
          style: context.textTheme.displayLarge,
          initialValue: initialValue,
          validator: validator,
          decoration: InputDecoration(
            fillColor: colors.mainColor.withOpacity(.3),
            suffixIcon: suffixIcon,
            hintText: hintText,
            contentPadding:
                const EdgeInsets.only(left: 20, top: 15, bottom: 18),
            prefixIcon: prefixIcon,
            // isDense: true,
            hintStyle: GoogleFonts.inter(
                color: hintColor ?? Colors.black, fontSize: fontSize.sp),
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
          onSaved: (value) {
            onSaved != null ? onSaved!(value) : null;
          },
        ),
      ],
    );
  }
}
