import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fittrack/src/core/base/models/days_model.dart';
import 'package:fittrack/src/core/base/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../constants/enums/firebase_enums.dart';
import '../../constants/enums/local_storage_enums.dart';
import '../../init/cache/cache_manager.dart';
import '../models/training_model.dart';
import 'i_firebase_services.dart';

class FirebaseServices extends IFirebaseServices {
  @override
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
      scopes: <String>[FirebaseEnums.email.value],
    ).signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    log("TOKEN : ${credential.accessToken}");
    await CacheManager.setString(
        LocalStorageEnums.token.name, credential.accessToken!);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<void> signOut() async {
    await CacheManager.clearAll();
    FirebaseAuth.instance.signOut();
  }

  @override
  Future<List<DaysModel>> fetchAllDays() async {
    List<DaysModel> dayList = [];

    try {
      final days = await FirebaseFirestore.instance
          .collection(FirebaseEnums.days.value)
          .get();
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

  @override
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      var user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      log(user.toString());
      log(user.user!.uid);
      await CacheManager.setString(
          LocalStorageEnums.token.name, user.user!.uid);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    var doc =
        FirebaseFirestore.instance.collection(FirebaseEnums.user.value).doc();
    var user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    if (user.user?.displayName == null) {
      user.user!.updateDisplayName(name);
    }
    try {
      final yeniUser = UserModel(
        id: user.user!.uid,
        email: email,
        name: name,
      );
      await doc.set(yeniUser.toJson());
      await CacheManager.setString(
        LocalStorageEnums.token.name,
        user.user!.uid,
      );
      await CacheManager.setString(
        LocalStorageEnums.userName.name,
        name,
      );
      log("NEW TOKEN : ${user.user?.uid}");
      return true;
    } catch (e) {
      return false;
    }
  }
}
