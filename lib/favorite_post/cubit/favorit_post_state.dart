part of 'favorit_post_cubit.dart';

@immutable
abstract class FavoritePostState {}

class FavoritePostInitial extends FavoritePostState {}

class FavoritePostLoading extends FavoritePostState {}

class FavoritePostLoaded extends FavoritePostState {
  final List<PostModel> favoList;

  FavoritePostLoaded({required this.favoList});
}

class FavoritePostError extends FavoritePostState {
  final String errorMessage;

  FavoritePostError({required this.errorMessage});
}
// states for deleting post from favorite post list...

class DeleteFavoritePost extends FavoritePostState {
  final List<PostModel> deleteFavoPost;

  DeleteFavoritePost({required this.deleteFavoPost});
}

// class AddToFavoritePost extends FavoritePostState {
//   final PostModel postModel;

//   AddToFavoritePost({required this.postModel});
// }
