import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../text/custom_text.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackbarWidget(
    BuildContext context,
    {required String message,
    int milliseconds = 600,
    String? label,
    bool? isSuccess = true,
    Color textColor = Colors.white,
    double? fontSize = 10}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: CustomText(
      message,
      maxLines: 5,
      textAlign: TextAlign.start,
      textStyle: TextStyle(
          fontSize: fontSize!.sp,
          fontWeight: FontWeight.w600,
          color: textColor),
    ),
    behavior: SnackBarBehavior.floating,
    duration: Duration(milliseconds: milliseconds),
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
    ),
    backgroundColor: isSuccess! ? Colors.green : Colors.red,
  ));
}
