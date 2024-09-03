import 'package:flutter/material.dart';
import 'package:todoapp/todolist.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _controller = TextEditingController();
  List toDoList = [
    ["melisayı kursa götür", false],
    ["staja git, flutter çalış konuları bitir", true],
  ];

  void checBoxChanged(int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  void saveNewTask() {
    if (_controller.text.trim().isEmpty) {
      // Kullanıcıya boş değer kaydedilemez mesajı göster
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Boş görev kaydedilemez!'),
          backgroundColor: Colors.redAccent.shade700,
        ),
      );
    } else {
      setState(() {
        toDoList.add([_controller.text, false]);
      });
      _controller.clear(); // Metin kutusunu temizler
    }
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.deepOrange.shade200,
      appBar: AppBar(
        title: const Text('Yapılacaklar Listesi'),
        centerTitle: true, // title ortalama
        backgroundColor: Colors.deepOrange.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (BuildContext context, index) {
          return todolist(
            taskname: toDoList[index][0],
            taskcompleted: toDoList[index][1],
            onChanged: (value) => checBoxChanged(index),
            deleteFunction: (value) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Yeni görev ekle",
                    hintStyle: TextStyle(
                      color: Colors.black87,
                    ),
                    filled: true,
                    fillColor: Colors.purple.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: saveNewTask,
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}