part of 'post_cubit.dart';

@immutable
abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class LoadingPosts extends PostState {}

class ErrorLoadingPosts extends PostState {
  final String message;

  const ErrorLoadingPosts({required this.message});

  @override
  List<Object> get props => [message];
}

class LoadedPosts extends PostState {
  final List<PostModel> postList;
  const LoadedPosts({required this.postList});

  @override
  List<Object> get props => [postList];
}

// class IsFavoritePost extends PostState {
//   final 
// }
