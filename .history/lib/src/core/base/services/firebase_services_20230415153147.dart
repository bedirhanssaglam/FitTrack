import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  final _fireCloud = FirebaseFirestore.instance.collection("days");
}
