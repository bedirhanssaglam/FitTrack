import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fittrack/src/core/base/bloc/training_bloc.dart';
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

class TrainingModel {
  final String trainingName;
  final String time;

  TrainingModel({required this.trainingName, required this.time});

  Map<String, dynamic> toJson() => {
        'trainingName': trainingName,
        'time': time,
      };

  factory TrainingModel.fromJson(Map<String, dynamic> json) {
    return TrainingModel(
      trainingName: json['trainingName'],
      time: json['time'],
    );
  }
}

class AddWorkOutView extends StatefulWidget {
  const AddWorkOutView({super.key, required this.day});

  final String day;

  @override
  State<AddWorkOutView> createState() => _AddWorkOutViewState();
}

class _AddWorkOutViewState extends State<AddWorkOutView> with BaseSingleton {
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
                title: "Training Add",
                onTap: () {
                  context.go(RouteEnums.workouts.routeName);
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    3.h.ph,
                    CustomText(
                      "Add the workout of your choice.",
                      textStyle: context.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    3.h.ph,
                    TextFormFieldWidget(
                      textEditingController: trainingNameController,
                      hintText: "Training Name",
                      onSaved: (value) {
                        trainingNameController.text = value;
                      },
                      onChanged: (value) {
                        trainingNameController.text = value;
                      },
                    ),
                    2.h.ph,
                    TextFormFieldWidget(
                      textEditingController: timeController,
                      hintText: "Training Time",
                      onSaved: (value) {
                        timeController.text = value;
                      },
                      onChanged: (value) {
                        timeController.text = value;
                      },
                    ),
                    2.h.ph,
                    Align(
                      alignment: Alignment.topRight,
                      child: CustomButton(
                        onTap: () {
                          context.read<TrainingBloc>().add(
                                AddNewTraining(
                                    widget.day,
                                    trainingNameController.text.trim(),
                                    timeController.text.trim(),
                                    context),
                              );
                        },
                        text: "Add",
                        width: 40,
                        height: 6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
