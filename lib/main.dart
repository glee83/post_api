import 'package:flutter/material.dart';
import 'package:post_app/route/route.dart';
import 'package:post_app/route/route_names.dart';
import './route/route.dart';
// import 'package:post_app/constants/strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: RouteNames.home,
      onGenerateRoute: AppRouting.generateRoute,
    );
  }
}
