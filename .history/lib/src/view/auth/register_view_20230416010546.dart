import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fittrack/src/core/base/bloc/auth/auth_bloc.dart';
import 'package:fittrack/src/core/base/services/firebase_services.dart';
import 'package:fittrack/src/core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:sizer/sizer.dart';

import '../../core/base/singleton/base_singleton.dart';
import '../../core/components/button/custom_button.dart';
import '../../core/components/snackbar/snackbar.dart';
import '../../core/components/text/custom_text.dart';
import '../../core/components/textFormField/text_form_field.dart';
import '../../core/components/viewHeaderWidget/view_header_widget.dart';
import '../../core/constants/enums/route_enums.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> with BaseSingleton {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ViewHeaderWidget(
                title: "Create an Account",
                onTap: () {
                  context.go(RouteEnums.login.routeName);
                },
              ),
              5.h.ph,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  children: [
                    TextFormFieldWidget(
                      controller: nameController,
                      hintText: "Your Name",
                      validator: (value) =>
                          functions.validateOperation(value, "Required field."),
                      onSaved: (value) {
                        nameController.text = value!;
                      },
                    ),
                    2.h.ph,
                    TextFormFieldWidget(
                      controller: emailController,
                      hintText: "E-mail",
                      validator: (value) =>
                          functions.validateOperation(value, "Required field."),
                      onSaved: (value) {
                        emailController.text = value!;
                      },
                    ),
                    2.h.ph,
                    TextFormFieldWidget(
                      controller: passwordController,
                      hintText: "Password",
                      isPassword: true,
                      validator: (value) =>
                          functions.validateOperation(value, "Required field."),
                      onSaved: (value) {
                        passwordController.text = value!;
                      },
                    ),
                  ],
                ),
              ),
              20.h.ph,
              CustomButton(
                onTap: () async {
                  log(nameController.text);
                  log(emailController.text);
                  log(passwordController.text);
                  await FirebaseServices()
                      .register(
                        name: nameController.text.trim(),
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      )
                      .then((_) => context.go(RouteEnums.login.routeName));
                },
                text: "Create Account",
              ),
              2.h.ph,
              CustomText(
                "Already have an account?",
                textStyle: context.textTheme.bodyMedium,
              ),
              2.h.ph,
              InkWell(
                onTap: () {
                  context.go(RouteEnums.login.routeName);
                },
                child: CustomText(
                  "Sign in",
                  textStyle: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
