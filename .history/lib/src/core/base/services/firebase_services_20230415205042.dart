import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fittrack/src/core/base/models/days_model.dart';
import 'package:fittrack/src/view/workouts/add_workout_view.dart';

class FirebaseServices {
  // final _fireCloud = FirebaseFirestore.instance.collection("days");

  Future<List<DaysModel>> getDays() async {
    List<DaysModel> dayList = [];

    try {
      final days = await FirebaseFirestore.instance.collection("days").get();
      days.docs.forEach((element) {
        return dayList.add(DaysModel.fromJson(element.data()));
      });
      return dayList;
    } on FirebaseException catch (e) {
      log("Failed with error '${e.code} : ${e.message}'");
      return dayList;
    }
  }

  Future<List<TrainingModel>> getTrainingByDay({required String day}) async {
    List<TrainingModel> trainingList = [];

    try {
      final trainings = await FirebaseFirestore.instance.collection(day).get();
      for (var element in trainings.docs) {
        continue;
      }
      return trainingList;
    } on FirebaseException catch (e) {
      log("Failed with error '${e.code} : ${e.message}'");
      return trainingList;
    }
  }
}
