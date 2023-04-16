import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fittrack/src/core/base/models/days_model.dart';

import '../models/training_model.dart';
import 'i_firebase_services.dart';

class FirebaseServices extends IFirebaseServices {
  @override
  Future<List<DaysModel>> fetchAllDays() async {
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

  @override
  Future<List<TrainingModel>> getTrainingByDay({required String day}) async {
    List<TrainingModel> trainingList = [];

    try {
      final trainings = await FirebaseFirestore.instance.collection(day).get();
      trainings.docs.forEach((element) {
        return trainingList.add(TrainingModel.fromJson(element.data()));
      });
      return trainingList;
    } on FirebaseException catch (e) {
      log("Failed with error '${e.code} : ${e.message}'");
      return trainingList;
    }
  }

  @override
  Future<bool> createTraining({
    required String day,
    required String trainingName,
    required String time,
  }) async {
    final trainingDoc = FirebaseFirestore.instance.collection(day).doc();
    try {
      final training = TrainingModel(
        id: trainingDoc.id,
        trainingName: trainingName,
        time: time,
      );
      await trainingDoc.set(training.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> updateTraining({
    required String id,
    required String day,
    String? trainingName,
    String? time,
  }) async {
    final trainingDoc = FirebaseFirestore.instance.collection(day).doc(id);
    try {
      await trainingDoc.update({
        "trainingName": trainingName,
        "time": time,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteTraining({required String id, required String day}) async {
    final trainingDoc = FirebaseFirestore.instance.collection(day).doc(id);
    try {
      await trainingDoc.delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
