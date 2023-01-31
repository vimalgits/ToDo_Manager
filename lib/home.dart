import 'package:flutter/material.dart';
import 'todoitems.dart';

import 'todo.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final todoList = ToDo.todoList();
  List<ToDo> _foundTodo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundTodo = todoList;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: Stack(
        children: [
          Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SearchBox(),
              Container(
                margin: EdgeInsets.all(20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'All ToDos',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (ToDo todoo in _foundTodo.reversed)
                      ToDoItems(
                        todo: todoo,
                        onToDochanged: _hadletodo,
                        onDeleteItem: _deleteItem,
                      ),
                  ],
                ),
              ),
            ],
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                      width: MediaQuery.of(context).size.width * .8,
                      height: MediaQuery.of(context).size.height * .09,
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black,
                                offset: Offset(0, 0),
                                blurRadius: 4,
                                spreadRadius: 0)
                          ]),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, top: 8),
                        child: TextField(
                          controller: _todoController,
                          decoration: InputDecoration(
                            hintText: 'Add a new task here',
                            border: InputBorder.none,
                          ),
                        ),
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 0, right: 20),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 106, 182, 116),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black,
                            offset: Offset(0, 0),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      shape: BoxShape.rectangle),
                  child: IconButton(
                      onPressed: (() => _addToDo(_todoController.text)),
                      icon: Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 50,
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,
              color: Colors.black,
              size: 30,
            ),
            CircleAvatar(child: Image.asset('img/profile.png'))
          ],
        ));
  }

  void _addToDo(String todo) {
    setState(() {
      todoList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: todo));
    });
    _todoController.clear();
  }

  void _hadletodo(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _search(String searchtxt) {
    List<ToDo> results = [];
    if (searchtxt.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) =>
              item.todoText!.toLowerCase().contains(searchtxt.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundTodo = results;
    });
  }

  void _deleteItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  Widget SearchBox() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        onChanged: (value) => _search(value),
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search_rounded),
            hintText: "Search",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
