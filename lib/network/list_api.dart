import 'dart:convert';

import 'package:post_app/model/list_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  static List<PostModel> posts = [];

  // Future fetchPosts() async {
  //   final response = await http.get(Uri.parse(baseUrl));

  //   if (response.statusCode == 200) {
  //     final post = jsonDecode(response.body) as List;
  //     for (int j = 0; j < post.length; j++) {
  //       post[j]['isFavorite'] = false;
  //     }
  //     posts = [...post];

  //     return posts;
  //   }
  // }

  Future<List<PostModel>> getPosts() async {
    final post = await http.get(Uri.parse(baseUrl));
    if (post.statusCode == 200) {
      final json = jsonDecode(post.body) as List;
      // print(json);

      for (int i = 0; i < json.length; i++) {
        json[i]['isFavorite'] = false;
      }
      print(posts);

      final postss = json.map((e) => PostModel.fromJson(e)).toList();
      posts = [...postss];
      return posts;
    } else {
      throw Exception('Failed to load. Please check your connection');
    }
  }

  // new json object with isFavorite to false

  static List<PostModel> isFavoritePost = [];

  // List<PostModel> getIsFavoritePost(bool isFavorite) {
  //   final post = posts.where((element) => element.isFavorite == isFavorite);
  //   return isFavoritePost = [...post];
  // }

  List<PostModel> getIsFavoritePost(bool isFavorite) {
    if (isFavoritePost.isNotEmpty) {
      return isFavoritePost;
      // final favoPost = posts.where((element) => element.isFavorite == true);
      // print(isFavoritePost.length);
      // return isFavoritePost = [...favoPost];
    } else {
      throw 'Not favorite post yet...';
    }
  }

  static addFavoritePost(PostModel post) {
    bool isFavorite = true;
    if (post.isFavorite != isFavorite) {
      print('this is from function ${post.isFavorite}');
      post.isFavorite = true;
      isFavoritePost.add(post);
      print('this is after adding ${post.isFavorite}');
    } else {
      print(post.isFavorite);
      return post;
    }
  }

  // static addFavoritePost(PostModel post) {
  //   if (!isFavoritePost.contains(post)) {
  //     isFavoritePost.add(post);
  //   } else {
  //     return 'you already mark post as favorite';
  //   }
  // }

  static deleteIsFavoritePost(int id, PostModel post) {
    // isFavoritePost.removeAt(id);

    bool isFavorite = true;
    if (post.isFavorite != isFavorite) {
      var newArr = isFavoritePost.where((element) => element.id != id);
      isFavoritePost = [...newArr];
      print('after deleting ${post.isFavorite}');
      return post.isFavorite = false;
    } else {
      return post.isFavorite = false;
    }
    // for (int k = 0; k < posts.length; k++) {
    //   posts[k].isFavorite = false;
    // }

    // print(isFavoritePost.length);
  }
}
