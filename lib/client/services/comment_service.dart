import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:mobile_app_3/client/models/comment.dart';

class CommentService {
  Future<List<CommentModel>> fetchComment(int pdId) async {
    List<CommentModel> commentList = [];
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.56.1/api/client/comment.php?fetchComment&pdId=$pdId'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        commentList = List<CommentModel>.from(
            jsonData.map((item) => CommentModel.fromJson(item)));
      }
    } catch (error) {
      print(error);
    }
    return commentList;
  }

  Future<bool> addComment(String comment, int userId, int pdId) async {
    try {
      // print('huhu');
      final response = await http.post(
        Uri.parse('http://192.168.56.1/api/client/comment.php'),
        body: jsonEncode(
          {
            'comment': comment,
            'userId': userId,
            'pdId': pdId,
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
      return false;
    }
  }
}
