class CategoryModel {
  final int id;
  final String name;

  CategoryModel({required this.id, required this.name});

  static CategoryModel fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['category_id'],
      name: json['category_name'],
    );
  }
}
