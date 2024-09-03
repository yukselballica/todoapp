import 'package:flutter/material.dart';

class todolist extends StatelessWidget {
  const todolist({
    super.key,
    required this.taskname,
    required this.taskcompleted,
    this.onChanged,
  });

  final String taskname;
  final bool taskcompleted;
  final Function(bool?)? onChanged;



  get toDoList => null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
        left: 20,
        bottom: 0,
        top: 20,
      ),
      child:  Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFF4CE0B3),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Checkbox(
                value: taskcompleted,
                onChanged: onChanged,
              checkColor: Colors.white,
              activeColor: Colors.red,
              side: BorderSide(
                color: Colors.black,
              ),
            ),
            Text(
              taskname,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
