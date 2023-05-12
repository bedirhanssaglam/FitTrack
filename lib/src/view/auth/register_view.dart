import 'package:fittrack/src/core/base/services/firebase_services.dart';
import 'package:fittrack/src/core/constants/app/app_constants.dart';
import 'package:fittrack/src/core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../core/base/singleton/base_singleton.dart';
import '../../core/components/button/custom_button.dart';
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

  bool validate() => _formKey.currentState!.validate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ViewHeaderWidget(
                title: AppConstants.instance.createAccountTitle,
                onTap: () {
                  context.go(RouteEnums.login.routeName);
                },
                isRegister: true,
              ),
              5.h.ph,
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    children: [
                      TextFormFieldWidget(
                        controller: nameController,
                        hintText: AppConstants.instance.yourName,
                        validator: (value) => functions.validateOperation(
                          value,
                          AppConstants.instance.formValidation,
                        ),
                        onSaved: (value) {
                          nameController.text = value!;
                        },
                      ),
                      2.h.ph,
                      TextFormFieldWidget(
                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        hintText: AppConstants.instance.email,
                        validator: (value) => functions.validateOperation(
                          value,
                          AppConstants.instance.formValidation,
                        ),
                        onSaved: (value) {
                          emailController.text = value!;
                        },
                      ),
                      2.h.ph,
                      TextFormFieldWidget(
                        controller: passwordController,
                        hintText: AppConstants.instance.password,
                        isPassword: true,
                        validator: (value) => functions.validateOperation(
                          value,
                          AppConstants.instance.formValidation,
                        ),
                        onSaved: (value) {
                          passwordController.text = value!;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              20.h.ph,
              CustomButton(
                onTap: () async {
                  if (validate()) {
                    await FirebaseServices()
                        .register(
                          name: nameController.text.trim(),
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        )
                        .then((_) => context.go(RouteEnums.home.routeName));
                  }
                },
                text: AppConstants.instance.createAccountButton,
              ),
              2.h.ph,
              Text(
                AppConstants.instance.haveAnAccount,
                style: TextStyle(
                  fontFamily: AppConstants.instance.fontFamily,
                  fontSize: 14.sp,
                ),
              ),
              2.h.ph,
              InkWell(
                onTap: () {
                  context.go(RouteEnums.login.routeName);
                },
                child: Text(
                  AppConstants.instance.signIn,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: AppConstants.instance.fontFamily,
                    fontSize: 14.sp,
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
