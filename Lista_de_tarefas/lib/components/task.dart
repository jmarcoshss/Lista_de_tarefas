import 'package:coisas_alura/components/difficulty.dart';
import 'package:coisas_alura/data/task_dao.dart';
import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  final String nome;
  final String image;
  final int difficulty;

  Task(this.nome, this.image, this.difficulty, {super.key});

  int nivel = 0;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {


  bool networkOrAsset() {
    if(widget.image.contains('http')){
      return true;
    }
    return false;
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.blue,
                ),
                height: 140,
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.black26,
                          ),
                          width: 72,
                          height: 100,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: networkOrAsset()? Image.network(
                                widget.image,
                                fit: BoxFit.cover,
                              ): Image.asset(
                                    widget.image,
                                    fit: BoxFit.cover,),)
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: 200,
                                child: Text(
                                  widget.nome,
                                  style: const TextStyle(fontSize: 24),
                                  overflow: TextOverflow.ellipsis,
                                )),
                            Difficulty(difficultyLevel: widget.difficulty,)
                          ],
                        ),
                        SizedBox(
                          width: 52,
                          height: 52,
                          child: ElevatedButton(
                            onLongPress: (){
                              TaskDao().delete(widget.nome);
                            },
                              onPressed: () {
                                setState(() {
                                  widget.nivel++;
                                });
                              },
                              child: const Column(
                                children: [
                                  Icon(Icons.arrow_drop_up),
                                  Text(
                                    'UP',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 200,
                          child: LinearProgressIndicator(
                            color: Colors.white,
                            value: (widget.difficulty > 0)
                                ? (widget.nivel / widget.difficulty) / 10
                                : 1,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'nivel: ${widget.nivel}',
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}