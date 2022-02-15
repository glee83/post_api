import 'package:flutter/material.dart';
import 'package:post_app/constants/strings.dart';
import 'package:post_app/screens/home_screen.dart';

class PostDetails extends StatelessWidget {
  int userId;
  int id;
  String title;
  String body;
  PostDetails({
    Key? key,
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightPrimaryColor,
      // appBar: AppBar(title: Text(title)),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 350.0,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: kTextColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: kDarkPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      body,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              width: 200.0,
              decoration: BoxDecoration(
                color: kDarkPrimaryColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(MaterialPageRoute(
                      builder: (context) => HomeScreen(title: title)));
                },
                child: const Text(
                  'Back',
                  style: TextStyle(color: kTextColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
