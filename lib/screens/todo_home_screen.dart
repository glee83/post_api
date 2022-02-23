import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/bloc/todo_cubit.dart';
import 'package:post_app/bloc/todo_state.dart';
import 'package:post_app/utils/constants.dart';

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({Key? key}) : super(key: key);

  @override
  _TodoHomeScreenState createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<TodoCubit>(context).addTodoToFav(listOfTodos);
  }

  void addTodoToFav(int id) {
    // Step 1 : Find the specific object by the id in listOfTodos
    // Step 2 : Modifier the status of the isFav to true in listOfTodos
    // Step 3 : Emit the new list to the Cubit
    BlocProvider.of<TodoCubit>(context).addTodoToFav(listOfTodos);
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
            child: BlocBuilder<TodoCubit, TodoState>(builder: (context, state) {
              late List<dynamic> localTodoList;
              if (state is TodoInitialState) {
                localTodoList = listOfTodos;
              }
              if (state is UserAddTodoToFav) {
                listOfFavTodo = state.todoFavList;
                listOfTodos = state.todoList;
              }
              if (state is UserRemoveTodoToFav) {
                listOfFavTodo = state.todoFavList;
                listOfTodos = state.todoList;
              }
              return ListView.builder(
                  itemCount: localTodoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              //Title
                              Text("${localTodoList[index]["title"]}"),
                              //Body
                              Text("${localTodoList[index]["body"]}")
                            ],
                          ),
                          localTodoList[index]["isFav"] == true
                              ? GestureDetector(
                                  onTap: () {
                                    addTodoToFav(localTodoList[index]["id"]);
                                  },
                                  child: const Icon(Icons.favorite,
                                      color: Colors.red))
                              : GestureDetector(
                                  onTap: () {
                                    removeTodoToFav(localTodoList[index]["id"]);
                                  },
                                  child: const Icon(Icons.favorite,
                                      color: Colors.grey))
                        ],
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
