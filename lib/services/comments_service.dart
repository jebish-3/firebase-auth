import 'dart:convert';
import 'package:firebaseaut/models/comments_models.dart';
import 'package:http/http.dart' as http;

class CommentService {
  Future<List<Comment>> getComments() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Comment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }
}
