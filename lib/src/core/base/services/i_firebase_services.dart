import 'package:firebase_auth/firebase_auth.dart';

import '../models/days_model.dart';
import '../models/training_model.dart';

abstract class IFirebaseServices {
  Future<bool> login({
    required String email,
    required String password,
  });
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  });
  Future<UserCredential> signInWithGoogle();
  Future<bool> isFirstEntry();
  Future<void> updateLoggedIn(bool isLoggedIn);
  Future<void> updateTokenFromStorage();
  Future<void> updateFirstEntry();
  Future<bool> isLoggedIn();
  Future<void> updateToken(String? token);
  Future<void> signOut();
  Future<List<DaysModel>> fetchAllDays();
  Future<List<TrainingModel>> getTrainingByDay({required String day});
  Future<bool> createTraining({
    required String day,
    required String trainingName,
    required String time,
  });
  Future<bool> updateTraining({
    required String id,
    required String day,
    String? trainingName,
    String? time,
  });
  Future<bool> deleteTraining({
    required String id,
    required String day,
  });
}
