class TrainingModel {
  final String trainingName;
  final String time;

  TrainingModel({required this.trainingName, required this.time});

  Map<String, dynamic> toJson() => {
        'trainingName': trainingName,
        'time': time,
      };

  factory TrainingModel.fromJson(Map<String, dynamic> json) {
    return TrainingModel(
      trainingName: json['trainingName'],
      time: json['time'],
    );
  }
}
