import 'dart:async';
import 'dart:developer';

import 'package:fittrack/src/core/base/services/firebase_services.dart';
import 'package:fittrack/src/core/extensions/num_extensions.dart';
import 'package:fittrack/src/core/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:sizer/sizer.dart';

import '../../core/base/bloc/auth/auth_bloc.dart';
import '../../core/base/singleton/base_singleton.dart';
import '../../core/components/button/custom_button.dart';
import '../../core/components/snackbar/snackbar.dart';
import '../../core/components/text/custom_text.dart';
import '../../core/components/textFormField/text_form_field.dart';
import '../../core/constants/enums/auth_status.dart';
import '../../core/constants/enums/local_storage_enums.dart';
import '../../core/constants/enums/route_enums.dart';
import '../../core/init/cache/cache_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with BaseSingleton {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool validate() => _formKey.currentState!.validate();

  isLogged() async {
    String? token = await CacheManager.getString(LocalStorageEnums.token.name);
    if (token != null && token != "") {
      context.go(RouteEnums.home.routeName);
    }
  }

  @override
  void initState() {
    super.initState();
    isLogged();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Form(
              key: _formKey,
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
                  TextFormFieldWidget(
                    controller: emailController,
                    hintText: "Your Email",
                  ),
                  3.h.ph,
                  TextFormFieldWidget(
                    controller: passwordController,
                    hintText: "Your password",
                    isPassword: true,
                  ),
                  3.h.ph,
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
                              textStyle:
                                  context.textTheme.titleMedium?.copyWith(
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
                            onTap: () async {
                              FirebaseServices().signInWithGoogle().then(
                                    (_) =>
                                        context.go(RouteEnums.home.routeName),
                                  );
                            },
                          ),
                          _buildSocialCard(
                            imagePath: "apple",
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                  25.h.ph,
                  CustomButton(
                    onTap: () {
                      // FirebaseServices()
                      //     .login(
                      //       email: emailController.text.trim(),
                      //       password: passwordController.text.trim(),
                      //     )
                      //     .then(
                      //       (value) => value
                      //           ? context.go(RouteEnums.home.routeName)
                      //           : snackbarWidget(
                      //               context,
                      //               message:
                      //                   "The password is invalid or the user does not have a password.",
                      //               isSuccess: false,
                      //               milliseconds: 1000,
                      //             ),
                      //     );
                      FirebaseServices()
                          .login(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim())
                          .then(
                              (value) => context.go(RouteEnums.home.routeName));
                    },
                    text: "Sign In",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector _buildSocialCard({
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
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
