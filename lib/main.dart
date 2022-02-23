import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/routes/app_routes.dart';
import 'package:post_app/screens/fav_todos_screen.dart';
import 'package:post_app/screens/todo_home_screen.dart';

import 'bloc/todo_cubit.dart';
import 'bloc/todo_state.dart';

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
      initialRoute: AppRoutes.home,
        onGenerateRoute: (setting) {
          switch (setting.name) {
            case (AppRoutes.home):
              return MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => TodoCubit(),
                    child: const TodoHomeScreen(),
                  ));
              break;
              case (AppRoutes.favorite):
              return MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => TodoCubit(),
                    child: const FavTodoScreen(),
                  ));
              break;



            default:
              return MaterialPageRoute(builder: (context) => const TodoHomeScreen());
          }
        }
    );
  }
}
