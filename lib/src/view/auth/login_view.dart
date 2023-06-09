import 'dart:async';

import 'package:fittrack/src/core/base/services/firebase_services.dart';
import 'package:fittrack/src/core/constants/app/app_constants.dart';
import 'package:fittrack/src/core/constants/enums/icon_enums.dart';
import 'package:fittrack/src/core/extensions/context_extensions.dart';
import 'package:fittrack/src/core/extensions/num_extensions.dart';
import 'package:fittrack/src/core/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../core/base/singleton/base_singleton.dart';
import '../../core/components/button/custom_button.dart';
import '../../core/components/snackbar/snackbar.dart';
import '../../core/components/text/custom_text.dart';
import '../../core/components/textFormField/text_form_field.dart';
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
    initializion();
    isLogged();
  }

  initializion() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
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
                    AppConstants.instance.loginHello,
                    textStyle: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.lightBlack,
                    ),
                  ),
                  2.h.ph,
                  CustomText(
                    AppConstants.instance.loginTitle,
                    textStyle: context.textTheme.titleMedium?.copyWith(
                      color: colors.silver,
                    ),
                  ),
                  5.h.ph,
                  TextFormFieldWidget(
                    controller: emailController,
                    textInputType: TextInputType.emailAddress,
                    hintText: AppConstants.instance.yourEmail,
                  ),
                  3.h.ph,
                  TextFormFieldWidget(
                    controller: passwordController,
                    hintText: AppConstants.instance.yourPassword,
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
                            child: Text(
                              AppConstants.instance.signUp,
                              style: TextStyle(
                                color: colors.mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                fontFamily: AppConstants.instance.fontFamily,
                              ),
                            ),
                          ),
                          3.w.pw,
                          Text(
                            "Or",
                            style: TextStyle(
                              color: colors.mainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              fontFamily: AppConstants.instance.fontFamily,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _buildSocialCard(
                              imagePath: IconEnums.facebook.iconName,
                              onTap: () {}),
                          _buildSocialCard(
                            imagePath: IconEnums.google.iconName,
                            onTap: () async {
                              if (validate()) {
                                FirebaseServices().signInWithGoogle().then(
                                      (_) =>
                                          context.go(RouteEnums.home.routeName),
                                    );
                              }
                            },
                          ),
                          _buildSocialCard(
                            imagePath: IconEnums.apple.iconName,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                  25.h.ph,
                  CustomButton(
                    onTap: () {
                      FirebaseServices()
                          .login(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim())
                          .then((value) => value
                              ? context.go(RouteEnums.home.routeName)
                              : SnackbarUtil.snackbarWidget(
                                  context,
                                  message: AppConstants.instance.deletedUser,
                                  isSuccess: false,
                                  milliseconds: 1500,
                                ));
                    },
                    text: AppConstants.instance.signIn,
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
