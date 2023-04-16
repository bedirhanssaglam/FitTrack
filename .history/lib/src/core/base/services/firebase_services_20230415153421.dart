import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fittrack/src/core/base/models/days_model.dart';

class FirebaseServices {
  final _fireCloud = FirebaseFirestore.instance.collection("days");

  Future<List<DaysModel>> getDays() async {
    List<DaysModel> dayList = [];

    try {
      final days = await FirebaseFirestore.instance.collection("days").get();
      days.docs.forEach((element) {
        return dayList.add(DaysModel.fromJson(element.data()));
      });
      return dayList;
    } on FirebaseException catch (e) {
      log("Failed with error '' ");
    }
  }
}
