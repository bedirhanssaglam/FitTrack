import 'dart:core';
import 'dart:io';
import 'package:fittrack/src/core/constants/app/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../components/text/custom_text.dart';

class BaseFunctions {
  static BaseFunctions? _instance;
  static BaseFunctions get instance {
    _instance ??= BaseFunctions._init();
    return _instance!;
  }

  BaseFunctions._init();

  animatedRouting({
    required GoRouterState state,
    required Widget route,
  }) =>
      CustomTransitionPage<void>(
        key: state.pageKey,
        child: route,
        transitionsBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation, Widget child) =>
            SlideTransition(
          position: animation.drive(
            Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeInOut)),
          ),
          child: child,
        ),
      );

  Widget platformIndicator() {
    return Center(
      child: Platform.isIOS
          ? CupertinoActivityIndicator(color: ColorConstants.instance.mainColor)
          : CircularProgressIndicator(color: ColorConstants.instance.mainColor),
    );
  }

  Widget errorText(String errorMessage) {
    return Center(
      child: CustomText(
        errorMessage,
        textStyle: TextStyle(
          fontSize: 14.sp,
        ),
      ),
    );
  }

  validateOperation(dynamic value, String errorMessage,
      {int minCharacterCount = 1}) {
    if (value == null || value.isEmpty || value.length < minCharacterCount) {
      return errorMessage;
    }
    return null;
  }

  closePopup(BuildContext context, {Object? backData}) {
    Navigator.of(context, rootNavigator: true).pop(backData);
  }
}
