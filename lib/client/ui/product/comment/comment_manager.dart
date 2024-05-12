import 'package:flutter/material.dart';
import 'package:mobile_app_3/client/models/comment.dart';
import 'package:mobile_app_3/client/services/comment_service.dart';

class CommentManager with ChangeNotifier {
  List<CommentModel> _listComment = [];
  List<CommentModel> get listComment => _listComment;

  Future<List<CommentModel>> fetchComment(int pdId) async {
    var _commentService = CommentService();
    try {
      _listComment = await _commentService.fetchComment(pdId);
      notifyListeners();
    } catch (error) {
      print(error);
    }

    return _listComment;
  }

  Future<void> addComment(String comment, int userId, int pdId) async {
    var _commentService = CommentService();

    bool isSuccess = await _commentService.addComment(comment, userId, pdId);
    if (isSuccess) {
      fetchComment(pdId);
      notifyListeners();
    }
  }

  int get listCommentCount {
    return _listComment.length;
  }
}
