import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fittrack/src/core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
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
  final String id;
  final String trainingName;
  final String time;

  TrainingModel(
      {required this.id, required this.trainingName, required this.time});

  Map<String, dynamic> toJson() => {
        'id': id,
        'trainingName': trainingName,
        'time': time,
      };
}

class AddWorkOutView extends StatefulWidget {
  const AddWorkOutView({super.key});

  @override
  State<AddWorkOutView> createState() => _AddWorkOutViewState();
}

class _AddWorkOutViewState extends State<AddWorkOutView> with BaseSingleton {
  Future createTraining() async {
    final docUser = FirebaseFirestore.instance.collection("Monday").doc();

    final user = TrainingModel(id: "", trainingName: "Running", time: "30");

    await docUser.set(user.toJson());
  }

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
                    const TextFormFieldWidget(
                      hintText: "Training Name",
                    ),
                    2.h.ph,
                    const TextFormFieldWidget(
                      hintText: "Training Time",
                    ),
                    2.h.ph,
                    Align(
                      alignment: Alignment.topRight,
                      child: CustomButton(
                        onTap: () {
                          snackbarWidget(context,
                              message: "Training was added");
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
