import 'package:post_app/model/list_model.dart';
import 'package:equatable/equatable.dart';

class FavoriteList extends Equatable {
  final List<PostModel> favoList;

  const FavoriteList({this.favoList = const <PostModel>[]});

  @override
  List<Object?> get props => [favoList];
}
