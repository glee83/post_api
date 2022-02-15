import 'package:flutter/material.dart';
import 'package:post_app/constants/strings.dart';
import 'package:post_app/model/list_model.dart';
import 'package:post_app/network/list_api.dart';
import 'package:post_app/screens/post_detail.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.all(0.0),
        child: FutureBuilder<List<PostModel>>(
            future: getPost(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<PostModel> posts = snapshot.data as List<PostModel>;
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                posts[index].id.toString(),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      posts[index].title,
                                      style: const TextStyle(
                                        color: kDarkPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => PostDetails(
                                                userId: posts[index].userId,
                                                id: posts[index].id,
                                                title: posts[index].title,
                                                body: posts[index].body),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        posts[index].body,
                                        maxLines: 3,
                                        // softWrap: true,
                                        // overflow: TextOverflow.clip,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Divider(
                            height: 1.0,
                            thickness: 1.0,
                            color: Color(0xffbdbdbd),
                          )
                        ],
                      ),
                    );
                  },
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'error',
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }

              return const Center(child: CircularProgressIndicator());
            }), // future: getPost(),
      ),
    );
  }
}
