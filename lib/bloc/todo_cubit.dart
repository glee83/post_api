
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/bloc/todo_state.dart';

import '../utils/constants.dart';

class TodoCubit extends Cubit<TodoState>{
  TodoCubit() : super(TodoInitialState());

  void addTodoToFav(int id ){
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
    emit(UserAddTodoToFav(todoList: listOfTodos,todoFavList:[]));
  }

  void removeTodoToFav(List todoList){
    emit(UserRemoveTodoToFav(todoList: todoList,todoFavList:[]));
  }

  void initFavScreenState(){
    emit(TodoFavScreenInitialState());
  }



}