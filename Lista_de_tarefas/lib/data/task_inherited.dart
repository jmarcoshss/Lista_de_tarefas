import 'package:coisas_alura/components/task.dart';
import 'package:flutter/material.dart';

class taskInherited extends InheritedWidget {
  taskInherited({
    super.key,
    required Widget child,
  }) : super(child: child);

  final List<Task> taskList = [
   Task(
        'encher a cara',
        'assets/image/nophoto.png',
        1),
    Task(
        'admirar arte',
        'https://images.pexels.com/photos/15911143/pexels-photo-15911143/free-photo-of-arte-galeria-de-arte-vista-traseira-sombrio.jpeg?auto=compress&cs=tinysrgb&w=600',
        3),
  ];

  void newTask(String name, String photo, int difficulty,){
    taskList.add(Task(name, photo, difficulty));
  }

  static taskInherited of(BuildContext context) {
    final taskInherited? result =
        context.dependOnInheritedWidgetOfExactType<taskInherited>();
    assert(result != null, 'No taskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(taskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
