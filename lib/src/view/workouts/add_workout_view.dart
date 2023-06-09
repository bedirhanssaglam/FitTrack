import 'package:fittrack/src/core/components/snackbar/snackbar.dart';
import 'package:fittrack/src/core/constants/app/app_constants.dart';
import 'package:fittrack/src/core/extensions/context_extensions.dart';
import 'package:fittrack/src/core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../core/base/bloc/training/training_bloc.dart';
import '../../core/base/singleton/base_singleton.dart';
import '../../core/components/button/custom_button.dart';
import '../../core/components/text/custom_text.dart';
import '../../core/components/textFormField/text_form_field.dart';
import '../../core/components/viewHeaderWidget/view_header_widget.dart';

class AddWorkOutView extends StatefulWidget {
  const AddWorkOutView({super.key, required this.day});

  final String day;

  @override
  State<AddWorkOutView> createState() => _AddWorkOutViewState();
}

class _AddWorkOutViewState extends State<AddWorkOutView> with BaseSingleton {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController trainingNameController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ViewHeaderWidget(
                title: AppConstants.instance.trainingAddTitle,
                onTap: () {
                  context.go("/workouts/${widget.day}");
                },
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      3.h.ph,
                      CustomText(
                        AppConstants.instance.addWorkoutChoice,
                        textStyle: context.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      3.h.ph,
                      TextFormFieldWidget(
                        controller: trainingNameController,
                        hintText: AppConstants.instance.trainingName,
                        validator: (value) => functions.validateOperation(
                          value,
                          AppConstants.instance.formValidation,
                        ),
                        onSaved: (value) {
                          trainingNameController.text = value!;
                        },
                      ),
                      2.h.ph,
                      TextFormFieldWidget(
                        controller: timeController,
                        textInputType: TextInputType.number,
                        hintText: AppConstants.instance.trainingTime,
                        validator: (value) => functions.validateOperation(
                          value,
                          AppConstants.instance.formValidation,
                        ),
                        onSaved: (value) {
                          timeController.text = value!;
                        },
                      ),
                      2.h.ph,
                      Align(
                        alignment: Alignment.topRight,
                        child: CustomButton(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<TrainingBloc>().add(
                                    AddNewTraining(
                                        widget.day,
                                        trainingNameController.text.trim(),
                                        timeController.text.trim(),
                                        context),
                                  );
                              context.go("/workouts/${widget.day}");
                            } else {
                              SnackbarUtil.snackbarWidget(
                                context,
                                message:
                                    AppConstants.instance.fillRequiredFields,
                                isSuccess: false,
                              );
                            }
                          },
                          text: AppConstants.instance.add,
                          width: 40,
                          height: 6,
                        ),
                      ),
                    ],
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
