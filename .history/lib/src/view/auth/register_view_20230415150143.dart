import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:sizer/sizer.dart';

import '../../core/base/singleton/base_singleton.dart';
import '../../core/components/button/custom_button.dart';
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
              const TextFormFieldWidget(
                hintText: "Your Name",
              ),
              2.h.ph,
              const TextFormFieldWidget(
                hintText: "E-mail",
              ),
              2.h.ph,
              const TextFormFieldWidget(
                hintText: "Password",
              ),
              20.h.ph,
              CustomButton(
                onTap: () {},
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
