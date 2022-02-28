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
  }

  void addTodoToFav(int id) {
    print("### ADD ###");
    // Step 1 : Find the specific object by the id in listOfTodos
    // Step 2 : Modifier the status of the isFav to true in listOfTodos
    // Step 3 : Emit the new list to the Cubit
    Map<String, dynamic> itemList =
        listOfTodos.firstWhere((item) => item["id"] == id);
    int index = listOfTodos.indexWhere((item) => item["id"] == id);
    var todo = {
      "id": itemList["id"],
      "title": itemList["title"],
      "body": itemList["body"],
      "isFav": true,
    };
    print("### THIS IS OBJECT INDEX : $index");
    print("### THIS IS THE ITEM MODIFIED: $todo");
    listOfTodos.removeAt(index);
    listOfTodos.insert(index, todo);
    print("### THIS IS THE NEW LIST: $listOfTodos");
    //Add it to the Fav list
    listOfFavTodo.add(todo);
    print("### THIS IS THE FAV TODO LIST: $listOfFavTodo");

    BlocProvider.of<TodoCubit>(context).addTodoToFav(listOfTodos);
  }

  void removeTodoToFav(int id) {
    // Step 1 : Find the specific object by the id in listOfFavTodos
    // Step 2 : Modifier the status of the isFav to true in listOfFavTodos
    // Step 3 : Emit the new list to the Cubit
    print("### REMOVE ###");
    Map<String, dynamic> itemList =
        listOfTodos.firstWhere((item) => item["id"] == id);
    int index = listOfTodos.indexWhere((item) => item["id"] == id);
    var todo = {
      "id": itemList["id"],
      "title": itemList["title"],
      "body": itemList["body"],
      "isFav": false,
    };
    print("### THIS IS OBJECT INDEX : $index");
    print("### THIS IS THE ITEM MODIFIED: $todo");
    listOfTodos.removeAt(index);
    listOfTodos.insert(index, todo);
    print("### THIS IS THE NEW LIST: $listOfTodos");
    BlocProvider.of<TodoCubit>(context).removeTodoToFav(listOfTodos);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: BlocBuilder<TodoCubit, TodoState>(
                builder: (providerContext, state) {
              late List<dynamic> localTodoList;
              if (state is TodoInitialState) {
                print("### THIS STATE IS EMITED");
                localTodoList = listOfTodos;
              }
              if (state is UserAddTodoToFav) {
                print("### THIS ADD TODO FAV STATE IS EMITED");
                listOfFavTodo = state.todoFavList;
                localTodoList = state.todoList;
              }
              if (state is UserRemoveTodoToFav) {
                print("### THIS REMOVE TODO FAV STATE IS EMITED");
                print("### THIS THE TODO ELEMENT : ${state.todoFavList}");
                listOfFavTodo = state.todoFavList;
                localTodoList = state.todoList;
              }
              return ListView.builder(
                  itemCount: localTodoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                //Title
                                Text(
                                  "${localTodoList[index]["title"]}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                //Body
                                Text(
                                  "${localTodoList[index]["body"]}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                          ),
                          localTodoList[index]["isFav"] == true
                              ? GestureDetector(
                                  onTap: () {
                                    removeTodoToFav(localTodoList[index]["id"]);
                                  },
                                  child: const Icon(Icons.favorite,
                                      color: Colors.red))
                              : GestureDetector(
                                  onTap: () {
                                    addTodoToFav(localTodoList[index]["id"]);
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
