import 'package:flutter/material.dart';
import 'package:post_app/constants/strings.dart';
import 'package:post_app/cubit/post_cubit.dart';
import 'package:post_app/model/list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/network/list_api.dart';
import 'package:post_app/route/route_names.dart';
import 'package:post_app/screens/favorite_post.dart';
import 'package:post_app/favorite_post/cubit/favorit_post_cubit.dart';

import 'package:post_app/screens/post_detail.dart';

class PostView extends StatefulWidget {
  // ApiService apiService;

  @override
  State<PostView> createState() => _PostViewState();
  bool isReload;
  PostView({Key? key, this.isReload = true}) : super(key: key);
}

class _PostViewState extends State<PostView> {
  bool isFavoritePost = false;
  bool isReload = true;
  var getPost = [];
  final GlobalKey<RefreshIndicatorState> refresh =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostCubit>(context).getPosts();
    // BlocProvider.of<FavoritPostCubit>(context);
    // isFavoritePost = !isFavoritePost;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('list of posts'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RouteNames.favoritePost);
            },
            icon: const Icon(
              Icons.favorite,
              color: kTextColor,
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        key: refresh,
        onRefresh: refreshPost,
        child: BlocBuilder<PostCubit, PostState>(
          builder: (context, state) {
            if (state is LoadingPosts) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ErrorLoadingPosts) {
              return const Text('something went wrong');
            } else if (state is LoadedPosts) {
              final postList = state.postList;
              return ListView.builder(
                itemCount: postList.length,
                itemBuilder: (context, index) {
                  PostModel post = postList[index];
                  return Dismissible(
                    key: ObjectKey(postList[index]),
                    background: Container(
                      color: Colors.green[100],
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.favorite,
                            color: kTextColor,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Favorite',
                            style: TextStyle(color: kTextColor),
                          ),
                        ],
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red[500],
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(
                            Icons.delete,
                            color: kTextColor,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            'Delete',
                            style: TextStyle(color: kTextColor),
                          ),
                        ],
                      ),
                    ),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        setState(() {
                          postList.removeAt(index);
                        });
                      } else {
                        setState(() {
                          ApiService.addFavoritePost(post);
                        });
                      }
                      // if (direction == startToEnd) {
                      // }
                    },
                    child: GestureDetector(
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(post.id.toString()),
                          ),
                          title: Text(
                            post.title,
                            maxLines: 1,
                          ),
                          subtitle: Text(
                            post.body,
                            maxLines: 2,
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              // print(postList[index].isFavorite = true);s

                              ApiService.addFavoritePost(post);
                              setState(() {
                                isFavoritePost = !isFavoritePost;
                                print(
                                    'this from ${postList[index].isFavorite}');
                              });
                            },

                            icon: postList[index].isFavorite
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    Icons.favorite,
                                  ),
                            // icon: const Icon(Icons.favorite),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PostDetails(
                              userId: post.userId,
                              id: post.id,
                              title: post.title,
                              body: post.body,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
            return const Center(child: Text('no connection...'));
          },
        ),
      ),
    );
  }

  Future refreshPost() async {
    if (isReload) {
      await Future.delayed(Duration(seconds: 1));
      getPost.clear();
      setState(() {});
    }
  }
}
