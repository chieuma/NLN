class CommentModel {
  final int id;
  final int userId;
  final String userName;
  final int productId;
  final DateTime dateTime;
  final String comment;

  CommentModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.productId,
    required this.dateTime,
    required this.comment,
  });

  Map<String, dynamic> toJSon() {
    return {
      'userId': userId,
      'productId': productId,
      'dateTime': dateTime,
      'comment': comment,
    };
  }

  static CommentModel fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['comment_id'],
      userId: json['comment_user_id'],
      userName: json['user_username'],
      productId: json['comment_pd_id'],
      dateTime: DateTime.parse(json['comment_date']),
      comment: json['comment_text'],
    );
  }
}
