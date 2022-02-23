import 'package:bloc/bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';
import 'package:post_app/model/list_model.dart';
import 'package:equatable/equatable.dart';
import 'package:post_app/network/list_api.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final ApiService apiService;
  PostCubit({required this.apiService}) : super(PostInitial());

  // void get posts async => emit(await apiService.getPosts());

  Future<void> getPosts() async {
    emit(LoadingPosts());
    try {
      final List<PostModel>? postList = await apiService.getPosts();
      emit(LoadedPosts(postList: postList ?? []));
      print(postList);
    } on Exception catch (err) {
      emit(ErrorLoadingPosts(message: 'Hello, $err'));
    } catch (err) {
      print('error: $err');
    }
  }

  // void getPosts() {
  //   emit(UserGettingPosts());

  //   try {
  //     apiService.getPosts().then((res) => {
  //         //   if (res != null)
  //         //     // {emit(UserSuccessfullyHasPosts(posts: null))}
  //         //   else
  //         //     // {emit(UserHasErrorGettingPosts())}
  //         // });
  //   } catch (e) {
  //     emit(UserHasErrorGettingPosts());
  //   }
  // }
}
