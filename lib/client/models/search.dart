class SearchModel {
  final int id;
  final String name;
  final int userId;

  SearchModel({
    required this.id,
    required this.name,
    required this.userId,
  });

  static SearchModel fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json['search_id'],
      name: json['search_name'],
      userId: json['search_user_id'],
    );
  }
}
