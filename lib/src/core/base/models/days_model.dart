class DaysModel {
  String? name;

  DaysModel({
    this.name,
  });

  factory DaysModel.fromJson(Map<String, dynamic> json) {
    return DaysModel(
      name: json['name'],
    );
  }
}
