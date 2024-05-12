class FavoriteModel {
  final int id;
  final int pdId;
  final int count;
  final int userId;

  FavoriteModel({
    required this.id,
    required this.pdId,
    required this.count,
    required this.userId,
  });

  static FavoriteModel fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['fav_id'],
      pdId: json['fav_pd_id'],
      userId: json['fav_user_id'],
      count: json['count'],
    );
  }
}
