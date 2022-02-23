import 'package:post_app/model/list_model.dart';
import 'package:post_app/network/list_api.dart';

class PostRepo {
  final ApiService apiService;

  const PostRepo({required this.apiService});

  Future<List<PostModel>?> getPostList() async {
    final response = await apiService.getPosts();
    if (response == null) {
      final data = response as List<dynamic>;
      return data
          .map(
            (e) => PostModel.fromJson(e),
          )
          .toList();
    }
    return null;
  }
}
