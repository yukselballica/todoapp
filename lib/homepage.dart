import 'package:flutter/material.dart';
import 'package:todoapp/todolist.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List toDoList = [
    ["flutter öğren", false],
    ["staja git", true],
  ];

  void checBoxChanged(int index){
    setState(() {
      toDoList[index][1]=!toDoList[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFeda28a),
      appBar: AppBar(
        title: const Text('Yapılacaklar Listesi'),
        centerTitle: true, // title ortalama
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: toDoList.length,
          itemBuilder: (BuildContext context, index) {
            return todolist(
              taskname: toDoList[index][0],
              taskcompleted: toDoList[index][1],
              onChanged:(value)=>checBoxChanged(index),
            );
          }),
    );
  }
}
