import 'package:flutter/cupertino.dart';

@immutable
abstract class TodoState {}

class TodoInitialState extends TodoState {}

class TodoFavScreenInitialState extends TodoState {}

class UserAddTodoToFav extends TodoState {
  List todoList;
  List todoFavList;

  UserAddTodoToFav({required this.todoList, required this.todoFavList});
}

class UserRemoveTodoToFav extends TodoState {
  List todoList;
  List todoFavList;

  UserRemoveTodoToFav({required this.todoList, required this.todoFavList});
}

class TodoClass extends TodoState {
  List todoList;

  TodoClass({required this.todoList});
}
