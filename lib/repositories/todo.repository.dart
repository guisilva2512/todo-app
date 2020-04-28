import 'dart:io';
import 'package:dio/dio.dart';
import 'package:todoapp/models/todo-item.model.dart';
import 'package:todoapp/user.dart';

class TodoRepository {
  // final BASE_URL = "http://192.168.0.104:60460/api";
  final BASE_URL = "https://192.168.0.104:44347/api";///v1/todos";
  // final BASE_URL = "https://192.168.0.104:44347/api";
  //http://192.168.0.104:3001/api/home

  Future<List<TodoItem>> getTodayTodos() async {
    // var todos = new List<TodoItem>();
    // todos.add(
    //   new TodoItem(
    //     id: "123456",
    //     title: "Hoje",
    //     done: false,
    //     date: DateTime.now(),
    //   ),
    // );
    // await Future.delayed(const Duration(milliseconds: 1500), () {});
    // return todos;

    // Emulador para acessar localhost usar https://10.0.2.2
    var url = "$BASE_URL/v1/todos/undone/today";
    Response response = await Dio().get(
      url,
      options: Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${user.token}'},
      ),
    );
    return (response.data as List)
        .map((todos) => TodoItem.fromJson(todos))
        .toList();
  }

  Future<List<TodoItem>> getTomorrowTodos() async {
    var url = "$BASE_URL/v1/todos/undone/tomorrow";
    // var url = "https://192.168.0.104:3000/api/v1/todos/undone/today";
    //https://192.168.0.104:44347/api/v1/todos/done/today
    Response response = await Dio().get(
      url,
      options: Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${user.token}'},
      ),
    );
    return (response.data as List)
        .map((todos) => TodoItem.fromJson(todos))
        .toList();
  }

  Future<List<TodoItem>> getAll() async {
    var url = "$BASE_URL/v1/todos";
    Response response = await Dio().get(
      url,
      options: Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${user.token}'},
      ),
    );
    return (response.data as List)
        .map((todos) => TodoItem.fromJson(todos))
        .toList();
  }

  Future<TodoItem> add(TodoItem item) async {
    var url = "$BASE_URL/v1/todos";
    // var url = "https://192.168.0.104:44347/api/v1/todos";

    try {
      Response response = await Dio().post(
        url,
        data: item,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'Bearer ${user.token}'},
        ),
      );
      return TodoItem.fromJson(response.data["data"]);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<TodoItem> markAsDone(TodoItem item) async {
    var url = "$BASE_URL/v1/todos/mark-as-done";

    try {
      Response response = await Dio().put(
        url,
        data: item,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'Bearer ${user.token}'},
        ),
      );
      return TodoItem.fromJson(response.data["data"]);
    } catch (e) {
      return null;
    }
  }
}
