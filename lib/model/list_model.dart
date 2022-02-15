import 'package:flutter/cupertino.dart';

class PostModel {
  int userId;
  int id;
  String title;
  String body;

  PostModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  PostModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'] as int,
        id = json['id'] as int,
        title = json['title'],
        body = json['body'];
}
