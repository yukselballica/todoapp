import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class todolist extends StatelessWidget {
  const todolist({
    super.key,
    required this.taskname,
    required this.taskcompleted,
    required this.onChanged,
    required this.deleteFunction,
    this.updateFunction,
  });

  final String taskname;
  final bool taskcompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;
  final Function(BuildContext)? updateFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
        left: 20,
        bottom: 0,
        top: 20,
      ),
      child: Slidable(
        startActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: updateFunction,
              icon: Icons.update,
              borderRadius: BorderRadius.circular(15),
              backgroundColor: Color(0XFFb967ff),
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(15),
              backgroundColor: Colors.red,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFFbae1ff),
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
              Expanded(
                child: Text(
                  taskname,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    decoration: taskcompleted ? TextDecoration.lineThrough : TextDecoration.none,
                    decorationColor: Colors.black,
                    decorationThickness: 2,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
