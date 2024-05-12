class BrandModel {
  final int id;
  final String name;
  final int categoryId;

  BrandModel({required this.id, required this.name, required this.categoryId});

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
        id: json['brand_id'],
        name: json['brand_name'],
        categoryId: json['brand_category_id']);
  }
}
