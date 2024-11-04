import 'package:flutter/material.dart';
import 'todo_history_screen.dart';

class TodoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TodoHistoryScreen()));
            },
          ),
        ],
      ),
      body: Center(child: Text('Todo List Screen')),
    );
  }
}
