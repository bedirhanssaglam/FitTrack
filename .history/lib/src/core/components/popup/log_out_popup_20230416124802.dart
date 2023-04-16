import 'package:fittrack/src/core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:sizer/sizer.dart';

import '../../base/bloc/auth/auth_bloc.dart';
import '../../base/functions/base_functions.dart';
import '../../constants/enums/route_enums.dart';
import '../button/custom_button.dart';
import '../text/custom_text.dart';
import 'main_popup.dart';

logOutPopup(BuildContext context) {
  return mainPopup(
    context,
    height: 20,
    width: 90,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          2.h.ph,
          CustomText(
            "Çıkış yapmak istediğinize emin misiniz?",
            textStyle: context.textTheme.displayMedium?.copyWith(
              fontSize: 15.sp,
            ),
            textAlign: TextAlign.center,
          ),
          1.h.ph,
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
                  context.read<AuthBloc>().add(const LogoutRequested());
                  context.go(RouteEnums.login.routeName);
                },
                text: "Log",
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