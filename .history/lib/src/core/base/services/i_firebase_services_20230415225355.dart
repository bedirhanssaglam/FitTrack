import '../models/days_model.dart';
import '../models/training_model.dart';

abstract class IFirebaseServices {
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
    String? trainingName,
    String? time,
  });
}
