class PromotionModel {
  int? id;
  final String name;
  final String info;
  final int condition; // điều kiện giá lớn hơn bao nhiêu mới giảm
  final int discount;
  final DateTime start;
  final DateTime end;

  PromotionModel(
      {this.id,
      required this.name,
      required this.info,
      required this.condition,
      required this.discount,
      required this.start,
      required this.end});

  static PromotionModel fromJson(Map<String, dynamic> json) {
    return PromotionModel(
      id: json['pr_id'],
      name: json['pr_name'],
      info: json['pr_info'],
      condition: json['pr_condition'],
      discount: json['pr_discount'],
      start: DateTime.parse(json['pr_start_date']),
      end: DateTime.parse(json['pr_end_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'info': info,
      'condition': condition,
      'discount': discount,
      'start': start.toIso8601String(),
      'end': end.toIso8601String(),
    };
  }
}
