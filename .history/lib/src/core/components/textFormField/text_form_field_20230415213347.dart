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
  });

  final String? hintText;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Your name",
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
      onChanged: ,
    );
  }
}
