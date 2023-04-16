import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kartal/kartal.dart';
import 'package:sizer/sizer.dart';

import '../../base/singleton/base_singleton.dart';
import '../../init/utils/typedefs.dart';
import '../text/custom_text.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String? hintText;
  final bool isPassword;
  final double? width;
  final double? height;
  final Function? onSaved;
  final Function? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  final EdgeInsets? contentPadding;
  final IconData? secondSuffixIcon;
  final StringFunction validator;
  final double? borderRadius;
  final int? maxLines;
  final TextInputType? textInputType;
  final Color? prefixIconColor;
  final String? title;
  final String? labelText;
  final double? fontSize;
  final Color? textColor;
  final bool? isThereShadow;
  final double? suffixIconSize;
  final String? initialValue;
  final FontWeight? hintTextFontWeight;
  final double? titleFontSize;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? textEditingController;
  final bool noElevation;
  final Color? backgroundColor;

  const TextFormFieldWidget({
    Key? key,
    this.hintText,
    this.width = 90,
    this.height = 6,
    this.titleFontSize = 14,
    this.isPassword = false,
    this.onSaved,
    this.onChanged,
    this.initialValue,
    this.prefixIcon,
    this.textEditingController,
    this.validator,
    this.labelText,
    this.borderRadius = 16,
    this.textInputType = TextInputType.text,
    this.prefixIconColor,
    this.contentPadding,
    this.suffixIcon,
    this.suffix,
    this.secondSuffixIcon,
    this.title,
    this.maxLines = 1,
    this.fontSize = 17,
    this.textColor,
    this.isThereShadow = false,
    this.suffixIconSize = 20,
    this.inputFormatters,
    this.hintTextFontWeight = FontWeight.normal,
    this.noElevation = false,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget>
    with BaseSingleton {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: FormField(
        builder: ((field) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.title != null
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: CustomText(
                        widget.title!,
                        textStyle: context.textTheme.displayLarge?.copyWith(
                          color: colors.black,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              SizedBox(
                height: widget.height?.h,
                width: widget.width?.w,
                child: TextFormField(
                  maxLines: widget.maxLines!,
                  controller: widget.textEditingController,
                  initialValue: widget.initialValue,
                  inputFormatters: widget.inputFormatters,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: widget.textInputType,
                  obscureText: widget.isPassword,
                  style: context.textTheme.displayMedium?.copyWith(
                      color: Colors.white,
                      fontSize: widget.fontSize!.sp,
                      fontWeight: widget.hintTextFontWeight),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(fontSize: 15.sp),
                    suffix: widget.suffix,
                    contentPadding: const EdgeInsets.all(12),
                    suffixIcon: widget.suffixIcon,
                    prefixIcon: widget.prefixIcon,
                    hintText: widget.hintText,
                    labelText: widget.labelText,
                    prefixIconColor: widget.prefixIconColor,
                    filled: true,
                    fillColor: widget.backgroundColor ??
                        colors.mainColor.withOpacity(.3),
                    hoverColor: colors.mainColor,
                    hintStyle: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(widget.borderRadius!)),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(widget.borderRadius!)),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(widget.borderRadius!)),
                      borderSide: BorderSide.none,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(widget.borderRadius!)),
                      borderSide: BorderSide.none,
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(widget.borderRadius!)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) => widget.validator != null
                      ? widget.validator!(value)
                      : null,
                  onSaved: (value) {
                    widget.onSaved != null ? widget.onSaved!(value) : null;
                  },
                  onChanged: (value) {
                    widget.onChanged != null ? widget.onChanged!(value) : null;
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
