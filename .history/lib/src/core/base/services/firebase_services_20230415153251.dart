import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fittrack/src/core/base/models/days_model.dart';

class FirebaseServices {
  final _fireCloud = FirebaseFirestore.instance.collection("days");

  Future<List<DaysModel>> getDays() async {
    List<DaysModel> days = [];

    try {
      final pro = await FirebaseFirestore.instance.collection("days").get();
      pro.docs.forEach((element) { })
    } catch (e) {}
  }
}