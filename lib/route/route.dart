import 'package:flutter/material.dart';
import 'package:post_app/cubit/post_cubit.dart';
import 'package:post_app/favorite_post/cubit/favorit_post_cubit.dart';
import 'package:post_app/network/list_api.dart';
import 'package:post_app/route/route_names.dart';
import 'package:post_app/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/widgets/post_view.dart';
import '../screens/favorite_post.dart';

class AppRouting {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => HomeScreen(title: 'Post App'));
      case RouteNames.post:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<PostCubit>(
                create: (context) =>
                    PostCubit(apiService: ApiService())..getPosts(),
              ),
              BlocProvider<FavoritPostCubit>(
                create: (context) =>
                    FavoritPostCubit(apiService: ApiService())..getFavoPosts(),
              ),
            ],
            child: PostView(),
          ),
        );
      case RouteNames.favoritePost:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<FavoritPostCubit>(
            create: (context) => FavoritPostCubit(apiService: ApiService()),
            child: const FavoritePost(),
          ),
        );
      default:
        throw 'not found';
    }
  }
}
