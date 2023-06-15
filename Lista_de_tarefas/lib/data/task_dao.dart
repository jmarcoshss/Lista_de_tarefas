import 'package:coisas_alura/components/task.dart';
import 'package:coisas_alura/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT)';

  static const String _tableName = 'taskTable';
  static const String _name = 'name';
  static const String _difficulty = 'difficulty';
  static const String _image = 'image';

  save(Task tarefa) async {
    print('acesou save');
    final Database database = await getDataBase();
    var itemExists = await find(tarefa.nome);
    Map<String,dynamic> taskMap = toMap(tarefa);
    if (itemExists.isEmpty) {
      print('nova tarefa');
      return await database.insert(_tableName, taskMap);
    } else {
      print('atualizando tarefa');
      return await database.update(_tableName, taskMap,
          where: '$_name = ?', whereArgs: [tarefa.nome]);
    }
  }

  Map<String,dynamic> toMap(Task tarefa){
    print('iniciando  tomap');
    final Map<String,dynamic> mapaDeTarefas = Map();
    mapaDeTarefas[_name] = tarefa.nome;
    mapaDeTarefas[_image] = tarefa.image;
    mapaDeTarefas[_difficulty] = tarefa.difficulty;
    print('to map feito $mapaDeTarefas');
    return mapaDeTarefas;
  }

  Future<List<Task>> findAll() async {
    print('acessando find all');
    final Database database = await getDataBase();
    final List<Map<String, dynamic>> result = await database.query(_tableName);
    print('encontrei $result');
    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> mapaDeTarefas) {
    print('convertendo toList');
    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in mapaDeTarefas) {
      final Task tarefa = Task(linha[_name], linha[_image], linha[_difficulty]);
      tarefas.add(tarefa);
    }
    print('$tarefas');
    return tarefas;
  }

  Future<List<Task>> find(String nomeDaTarefa) async {
    print('acessando find');
    final Database database = await getDataBase();
    final List<Map<String, dynamic>> result = await database
        .query(_tableName, where: '$_name = ?', whereArgs: [nomeDaTarefa]);
    print('objeto encontrado ${toList(result)}');
    return toList(result);
  }

  delete(String nomeDaTarefa) async {
    print('deletano tarefa $nomeDaTarefa');
    final Database database = await getDataBase();
    return database.delete(_tableName, where: '$_name = ?',
        whereArgs: [nomeDaTarefa]);
  }
}
