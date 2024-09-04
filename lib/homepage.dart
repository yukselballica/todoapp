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
    ["Görev deneme 1", false],
    ["Görev deneme 2", true],
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

  void updateTask(int index, String newTask, bool newStatus) {

    if(newTask.length<1){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Boş görev kaydedilemez!'),
          backgroundColor: Colors.redAccent.shade700,
        ),
      );
    }
    else{
      setState(() {
        toDoList[index] = [newTask, newStatus];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0XFFffffba),
      appBar: AppBar(
        title: const Text(
            'Yapılacaklar Listesi',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        centerTitle: true, // title ortalama
        backgroundColor: Color(0XFFffb3ba),
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
            updateFunction: (context) {
              TextEditingController taskController = TextEditingController(text: toDoList[index][0]);
              bool newStatus = toDoList[index][1];

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return AlertDialog(
                        backgroundColor: Color(0XFFbaffc9),
                        //backgroundColor: Color(0xFF4CE0B3),
                        title: Text(
                            "Görevi Güncelle",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: taskController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.purple.shade50 ,
                                  hintText: 'Yeni Görev',
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            CheckboxListTile(
                              title: Text("Tamamlandı mı?",style: TextStyle(fontWeight: FontWeight.bold),),
                              value: newStatus,
                              onChanged: (bool? value) {
                                setState(() {
                                  newStatus = value ?? false;
                                });
                              },
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "İptal" ,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple.shade900,
                              ),
                            ),
                          ),
                          TextButton(
                            child: Text(
                              "Güncelle",
                              style: TextStyle(
                                  color: Colors.deepPurple.shade900,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              updateTask(index, taskController.text, newStatus);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
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
