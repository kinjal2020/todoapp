import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:provider/provider.dart';

// import 'package:timer_count_down/timer_count_down.dart';
import 'package:todoapp/model/todo_model.dart';

import '../../detailscreen/details_screen.dart';
import '../../utils/colors.dart';
import '../provider/todo_provider.dart';

class SingleTaskScreen extends StatefulWidget {
  final TodoModel todo;

  const SingleTaskScreen({super.key, required this.todo});

  @override
  State<SingleTaskScreen> createState() => _SingleTaskScreenState();
}

class _SingleTaskScreenState extends State<SingleTaskScreen> {
  Timer? _timer;
  int _start = 600;

  @override
  void initState() {
    // TODO: implement initState
    print('innit state');
    print(widget.todo.taskStatus);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TodoDetailsScreen(
                    title: widget.todo.taskTitle,
                    desc: widget.todo.taskDescription,
                    status: widget.todo.taskStatus,
                    timer: widget.todo.taskTimer,
                    id: widget.todo.taskId,
                  )));
        },
        child: Container(
          // height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: grayColor.withOpacity(0.2),
                  blurRadius: 10,
                  blurStyle: BlurStyle.outer,
                  spreadRadius: 1,
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, top: 15, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.todo.taskStatus.toUpperCase(),
                      style: TextStyle(
                          color:
                              Color((Random().nextDouble() * 0xFFFFFF).toInt())
                                  .withOpacity(1.0),
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          openAlertDialog(widget.todo.taskId);
                        },
                        icon: Icon(
                          Icons.remove_circle_outline,
                          color: redColor,
                        ))
                  ],
                ),
                Divider(color: grayColor.withOpacity(0.2)),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Container(
                        height: 50,
                        width: 3,
                        color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(1.0)),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.todo.taskTitle,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Container(
                          // height: 10,
                          width: MediaQuery.of(context).size.width - 100,
                          child: Text(
                            widget.todo.taskDescription,
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                            style: TextStyle(color: grayColor),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      size: 20,
                      color: grayColor.withOpacity(1.0),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    //
                    (widget.todo.taskStatus == "Running")
                        ? TimerCountdown(
                            format: CountDownTimerFormat.minutesSeconds,
                            endTime: DateTime.now().add(
                              Duration(
                                minutes: int.parse(widget.todo.taskTimer),
                                seconds: 00,
                              ),
                            ),
                            onEnd: () {

                            },
                          )
                        : Text(
                            widget.todo.taskTimer + ' Min',
                            style: Theme.of(context).textTheme.titleSmall,
                          )
                    // Text(_start.toString())
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  openAlertDialog(int id) {
    final providerVar = Provider.of<TodoProvider>(context, listen: false);

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).accentColor,
            title: Text(
              'Delete',
              style: TextStyle(color: redColor, fontWeight: FontWeight.bold),
            ),
            content: Text(
              "Are you sure want to delete task?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            actions: [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),)),
                ),
                child: Text(
                  "Cancel",
                  style: Theme.of(context).textTheme.titleSmall
                ),
              ),
              OutlinedButton(
                onPressed: () async {
                  await providerVar.deleteTask(id);
                  await providerVar.getTaskList();
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))),
                ),
                child: Text(
                  "Yes",
                    style: Theme.of(context).textTheme.titleSmall
                ),
              )
            ],
          );
        });
  }
}
