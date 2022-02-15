import 'dart:convert';

import 'package:post_app/model/list_model.dart';
import 'package:http/http.dart' as http;

String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

Future<List<PostModel>> getPost() async {
  final post = await http.get(Uri.parse(baseUrl));
  print(post.body);
  return (jsonDecode(post.body) as List)
      .map((e) => PostModel.fromJson(e))
      .toList();
  // return
  // return
}
