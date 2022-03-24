import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:post_app/model/list_model.dart';
import 'package:post_app/network/list_api.dart';

part 'favorit_post_state.dart';

class FavoritPostCubit extends Cubit<FavoritePostState> {
  FavoritPostCubit({required this.apiService}) : super(FavoritePostInitial());
  final ApiService apiService;
  // List<PostModel> favoritePostList = [];

  void getFavoPosts() {
    emit(FavoritePostInitial());
    try {
      bool isFavorite = true;
      final List<PostModel>? favoList =
          apiService.getIsFavoritePost(isFavorite);
      emit(FavoritePostLoaded(favoList: favoList ?? []));
    } on Exception catch (err) {
      emit(
        FavoritePostError(
          errorMessage:
              "an error occure when fetching the favorite post list. $err",
        ),
      );
    } catch (err) {
      print('fetch favorite post $err');
    }
  }

  void deleteFavoPost(int id, PostModel post) {
    emit(FavoritePostInitial());
    try {
      bool isFavorite = true;
      // final List<PostModel> post = apiService.deleteIsFavoritePost(id, post) as List<PostModel>;
      // var newPost = post.where((element) => element.id != id);
      // emit(DeleteFavoritePost(deleteFavoPost: newPost));
    } on Exception catch (err) {
      FavoritePostError(
        errorMessage:
            "an error occure when fetching the favorite post list. $err",
      );
    }
  }

  // void addToFavoritePost(PostModel postModel) {
  //   emit(FavoritePostInitial());

  //   try {
  //     final PostModel post = apiService.addFavoritePost(postModel);
  //     emit(AddToFavoritePost(postModel: post));
  //   } catch (e) {
  //     emit(
  //       FavoritePostError(errorMessage: ' $e could not add to  favorite list'),
  //     );
  //   }
  // }
}
