import 'package:flutter/material.dart';
import 'package:post_app/constants/strings.dart';
import 'package:post_app/favorite_post/cubit/favorit_post_cubit.dart';
import 'package:post_app/model/list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/network/list_api.dart';
import 'package:post_app/widgets/post_view.dart';

class FavoritePost extends StatefulWidget {
  // List<PostModel> favoPost;
  const FavoritePost({Key? key}) : super(key: key);

  @override
  State<FavoritePost> createState() => _FavoritePostState();
}

class _FavoritePostState extends State<FavoritePost> {
  List<PostModel> favoPost = [];
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FavoritPostCubit>(context).getFavoPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite Posts',
          style: TextStyle(color: kTextColor),
        ),
        actions: [
          Container(
            color: kSecondaryColor,
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                const Text(
                  'back',
                  style: TextStyle(color: kTextColor),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(
                      MaterialPageRoute(
                        builder: (context) => PostView(
                          isReload: true,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ],
            ),
          )
        ],
      ),
      body: BlocBuilder<FavoritPostCubit, FavoritePostState>(
        builder: (context, state) {
          if (state is FavoritePostLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FavoritePostLoaded) {
            final favoPost = state.favoList;
            return ListView.builder(
              itemCount: favoPost.length,
              itemBuilder: (context, index) {
                PostModel post = favoPost[index];
                return Dismissible(
                  key: ObjectKey(post),
                  background: Container(
                    color: kDangerColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.delete,
                          color: kTextColor,
                        ),
                        Text('delete'),
                      ],
                    ),
                  ),
                  onDismissed: (direction) {
                    ApiService.deleteIsFavoritePost(post.id, post);

                    setState(() {
                      ApiService.isFavoritePost;
                    });
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(post.title),
                      subtitle: Text(post.body),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            ApiService.deleteIsFavoritePost(post.id, post);
                          });

                          BlocProvider.of<FavoritPostCubit>(context)
                              .getFavoPosts();
                          // print(post);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('no favorite post'));
        },
      ),
    );
  }
}
