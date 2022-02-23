
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/bloc/todo_state.dart';

class TodoCubit extends Cubit<TodoState>{
  TodoCubit() : super(TodoInitialState());

  void addTodoToFav(List todoList){
    emit(UserAddTodoToFav(todoList: todoList,todoFavList:[]));
  }

  void removeTodoToFav(List todoList){
    emit(UserRemoveTodoToFav(todoList: todoList,todoFavList:[]));
  }

  void initFavScreenState(){
    emit(TodoFavScreenInitialState());
  }



}