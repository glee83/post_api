import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/bloc/todo_cubit.dart';
import 'package:post_app/bloc/todo_state.dart';
import 'package:post_app/utils/constants.dart';

class FavTodoScreen extends StatefulWidget {
  const FavTodoScreen({Key? key}) : super(key: key);

  @override
  _FavTodoScreenState createState() => _FavTodoScreenState();
}

class _FavTodoScreenState extends State<FavTodoScreen> {



  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<TodoCubit>(context).initFavScreenState();
  }

  void removeTodoToFav(int id) {
    // Step 1 : Find the specific object by the id in listOfFavTodos
    // Step 2 : Modifier the status of the isFav to true in listOfFavTodos
    // Step 3 : Emit the new list to the Cubit
    BlocProvider.of<TodoCubit>(context).removeTodoToFav(listOfFavTodo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child:
            BlocBuilder<TodoCubit, TodoState>(builder: (providerContext, state) {
              late List<dynamic> localTodoList;
              if (state is TodoFavScreenInitialState) {
                localTodoList = listOfFavTodo;
              }
              if (state is UserRemoveTodoToFav) {
                listOfFavTodo = state.todoFavList;
                localTodoList = state.todoFavList;
                listOfTodos = state.todoList;
              }
              return ListView.builder(
                  itemCount: localTodoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                //Title
                                Text("${localTodoList[index]["title"]}"),
                                const SizedBox(height: 10),
                                //Body
                                Text("${localTodoList[index]["body"]}")
                              ],
                            ),
                            GestureDetector(
                                onTap: () {
                                  removeTodoToFav(localTodoList[index]["id"]);
                                },
                                child: const Icon(Icons.delete_forever,
                                    color: Colors.grey))
                          ],
                        ),
                      ),
                    );
                  });
            }),
          )
        ],
      ),
    );
  }
}
