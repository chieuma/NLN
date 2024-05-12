class ColorsModel {
  final int? colorId;
  final int? pdId;
  final String name;
  final String nameVn;

  ColorsModel({
    this.colorId,
    this.pdId,
    required this.name,
    required this.nameVn,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'nameVn': nameVn,
    };
  }

  ColorsModel fromJson(Map<String, dynamic> json) {
    return ColorsModel(
      colorId: json['color_id'],
      pdId: json['color_pd_id'],
      name: json['color_name'],
      nameVn: json['color_nameVn'],
    );
  }
}
