import 'dart:developer';

import 'package:fit_track/src/core/base/singleton/base_singleton.dart';
import 'package:fit_track/src/core/components/button/custom_button.dart';
import 'package:fit_track/src/core/components/text/custom_text.dart';
import 'package:fit_track/src/core/components/textFormField/text_form_field.dart';
import 'package:fit_track/src/core/constants/enums/route_enums.dart';
import 'package:fit_track/src/core/extensions/num_extensions.dart';
import 'package:fit_track/src/core/extensions/string_extensions.dart';
import 'package:fit_track/src/view/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:sizer/sizer.dart';

import '../../core/init/cache/cache_manager.dart';
import '../../core/init/utils/google_sign_helper.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with BaseSingleton {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (CacheManager.instance.getStringValue(SharedKeys.token).isNotEmpty) {
        context.go(RouteEnums.home.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.h.ph,
                CustomText(
                  "Hi, Welcome Back",
                  textStyle: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colors.lightBlack,
                  ),
                ),
                2.h.ph,
                CustomText(
                  "Login into your account",
                  textStyle: context.textTheme.titleMedium?.copyWith(
                    color: colors.silver,
                  ),
                ),
                5.h.ph,
                const TextFormFieldWidget(
                  hintText: "Your name",
                ),
                2.h.ph,
                const TextFormFieldWidget(
                  hintText: "Password",
                  isPassword: true,
                ),
                4.h.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            context.go(RouteEnums.register.routeName);
                          },
                          child: CustomText(
                            "Sign Up",
                            textStyle: context.textTheme.titleMedium?.copyWith(
                              color: colors.mainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                        3.w.pw,
                        CustomText(
                          "Or",
                          textStyle: context.textTheme.titleMedium?.copyWith(
                            color: colors.mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _buildSocialCard(imagePath: "facebook", onTap: () {}),
                        _buildSocialCard(
                          imagePath: "google",
                          onTap: () {
                            FirebaseService()
                                .signInWithGoogle()
                                .then((_) => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const HomeView(),
                                      ),
                                    ));
                          },
                        ),
                        _buildSocialCard(imagePath: "apple", onTap: () {}),
                      ],
                    ),
                  ],
                ),
                25.h.ph,
                CustomButton(
                  onTap: () {
                    context.go(RouteEnums.home.routeName);
                  },
                  text: "Sign In",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell _buildSocialCard({
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 8.h,
        width: 16.w,
        padding: EdgeInsets.all(14.sp),
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        decoration: BoxDecoration(
          color: colors.lightPurple.withOpacity(.3),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(imagePath.toSvg),
      ),
    );
  }
}
