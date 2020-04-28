import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/controllers/todo.controller.dart';
import 'package:todoapp/stores/app.store.dart';
import 'package:todoapp/views/create-todo.view.dart';
import 'package:todoapp/widgets/navbar.widget.dart';
import 'package:todoapp/widgets/todo-list.widget.dart';
import 'package:todoapp/widgets/user-card.widget.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<AppStore>(context);
    final controller = new TodoController(store);

    if (store.currentState == "none") {
      controller.changeSelection("today");
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          UserCard(),
          NavBar(),
          Expanded(
            child: Container(
              child: TodoList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateTodoView(),
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
