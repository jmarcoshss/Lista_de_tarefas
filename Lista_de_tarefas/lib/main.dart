import 'package:coisas_alura/data/task_inherited.dart';
import 'package:coisas_alura/screens/form_screen.dart';
import 'package:coisas_alura/screens/inicial_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      home:  taskInherited(child: const InicialScreen())
    );
  }
}







