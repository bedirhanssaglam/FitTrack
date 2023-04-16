class TrainingModel {
  final String id;
  String? trainingName;
  String? time;

  TrainingModel(
      {required this.id, required this.trainingName, required this.time});

  Map<String, dynamic> toJson() => {
        'id': id,
        'trainingName': trainingName,
        'time': time,
      };

  factory TrainingModel.fromJson(Map<String, dynamic> json) {
    return TrainingModel(
      id: json['id'],
      trainingName: json['trainingName'],
      time: json['time'],
    );
  }
}
