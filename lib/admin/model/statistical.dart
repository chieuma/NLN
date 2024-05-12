class StatisticalModel {
  final int id;
  final int userId;
  final int count;

  StatisticalModel({
    required this.id,
    required this.userId,
    required this.count,
  });

  static StatisticalModel fromJson(Map<String, dynamic> json) {
    return StatisticalModel(
      id: json['st_id'],
      userId: json['st_user_id'],
      count: json['Count'],
    );
  }
}
