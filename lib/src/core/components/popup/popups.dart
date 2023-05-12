import 'package:fittrack/src/core/extensions/context_extensions.dart';
import 'package:fittrack/src/core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../base/functions/base_functions.dart';
import '../../base/services/firebase_services.dart';
import '../../constants/app/color_constants.dart';
import '../../constants/enums/route_enums.dart';
import '../button/custom_button.dart';
import '../text/custom_text.dart';

@immutable
class PopupUtils {
  const PopupUtils._();

static  Future<dynamic> mainPopup(
  BuildContext context, {
  double height = 25,
  double width = double.infinity,
  required Widget child,
}) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return ScaleTransition(
        scale: Tween<double>(begin: .5, end: 1).animate(animation),
        child: AlertDialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: ColorConstants.instance.mainColor,
              width: 1.5,
            ),
          ),
          content: SizedBox(
            height: height.h,
            width: width,
            child: child,
          ),
        ),
      );
    },
  );
}


  static logOutPopup(BuildContext context) {
    return mainPopup(
      context,
      width: 90,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            2.h.ph,
            CustomText(
              "Are you sure you want to sign out?",
              textStyle: context.textTheme.headlineSmall?.copyWith(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            3.h.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  onTap: () {
                    BaseFunctions.instance.closePopup(context);
                  },
                  text: "Cancel",
                  width: 20,
                  height: 4.5,
                ),
                CustomButton(
                  onTap: () async {
                    FirebaseServices()
                        .signOut()
                        .then((_) => context.go(RouteEnums.login.routeName));
                  },
                  text: "Sign out",
                  width: 30,
                  height: 4.5,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
