import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fittrack/src/core/base/models/training_model.dart';
import 'package:fittrack/src/core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class UpdateWorkoutView extends StatefulWidget {
  const UpdateWorkoutView({
    super.key,
    required this.day,
    required this.trainingModel,
  });

  final String day;
  final TrainingModel trainingModel;

  @override
  State<UpdateWorkoutView> createState() => _UpdateWorkoutViewState();
}

class _UpdateWorkoutViewState extends State<UpdateWorkoutView>
    with BaseSingleton {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ViewHeaderWidget(
                title: widget.trainingModel.trainingName ?? "",
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
                        "After changing the program, don't forget\nto update it.",
                        textStyle: context.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      3.h.ph,
                      TextFormFieldWidget(
                        initialValue: widget.trainingModel.trainingName,
                        onSaved: (value) {
                          widget.trainingModel.trainingName = value;
                        },
                        onChanged: (value) {
                          widget.trainingModel.trainingName = value;
                        },
                        validator: (value) => functions.validateOperation(
                            value, "Required field."),
                      ),
                      2.h.ph,
                      TextFormFieldWidget(
                        initialValue: widget.trainingModel.time,
                        onSaved: (value) {
                          widget.trainingModel.time = value;
                        },
                        onChanged: (value) {
                          widget.trainingModel.time = value;
                        },
                        validator: (value) => functions.validateOperation(
                            value, "Required field."),
                      ),
                      2.h.ph,
                      Align(
                        alignment: Alignment.topRight,
                        child: CustomButton(
                          onTap: () {
                            final docUser = FirebaseFirestore.instance
                                .collection(widget.day)
                                .doc(widget.trainingModel.id);
                            docUser.update({
                              "trainingName": widget.trainingModel.trainingName,
                              "time": widget.trainingModel.time,
                            });
                          },
                          text: "Update",
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
