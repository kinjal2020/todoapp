import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/homescreen/screen/home_screen.dart';
import 'package:todoapp/utils/colors.dart';

import '../homescreen/provider/todo_provider.dart';

enum TaskStatus { Created, Running, Pause, Completed }

class TodoDetailsScreen extends StatefulWidget {
  final String title;
  final String desc;
  final String status;
  final String timer;
  final int id;

  const TodoDetailsScreen(
      {super.key,
      required this.title,
      required this.desc,
      required this.status,
      required this.timer,
      required this.id});

  @override
  State<TodoDetailsScreen> createState() => _TodoDetailsScreenState();
}

class _TodoDetailsScreenState extends State<TodoDetailsScreen> {
  TaskStatus status = TaskStatus.Completed;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController timerController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  getTaskStatus(String status) async {
    final providerVar = Provider.of<TodoProvider>(context, listen: false);
    await providerVar.updateTaskStatus(status, widget.id);
    providerVar.getTaskList();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }

  updateTask() async {
    final providerVar = Provider.of<TodoProvider>(context, listen: false);
    await providerVar.updateTask(titleController.text, descController.text,
        status.name, timerController.text, widget.id);
    providerVar.getTaskList();
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    // TODO: implement initState
    titleController.text = widget.title;
    descController.text = widget.desc;
    timerController.text = widget.timer;
    if (widget.status == TaskStatus.Created.name) {
      setState(() {
        status = TaskStatus.Created;
      });
    } else if (widget.status == TaskStatus.Running.name) {
      setState(() {
        status = TaskStatus.Running;
      });
    } else if (widget.status == TaskStatus.Pause.name) {
      setState(() {
        status = TaskStatus.Pause;
      });
    } else {
      setState(() {
        status = TaskStatus.Completed;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).bottomAppBarColor,
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 150,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      CupertinoIcons.back,
                      color: whiteColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                      onPressed: () {
                        openBottomSheet();
                      },
                      child: Text(
                        'Edit',
                        style: TextStyle(fontSize: 20, color: whiteColor),
                      ))
                ],
              ),
            ),
          ),
          Container(
            height: height - 196,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.desc,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: grayColor.withOpacity(1.0),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Status',
                        style: Theme.of(context).textTheme.titleMedium,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Radio(
                            value: TaskStatus.Created,
                            groupValue: status,
                            onChanged: (TaskStatus? value) {
                              setState(() {
                                status = value!;
                              });
                              getTaskStatus(status.name);
                            },
                          ),
                          Text(
                            "Created",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Radio(
                            value: TaskStatus.Running,
                            groupValue: status,
                            onChanged: (TaskStatus? value) {
                              setState(() {
                                status = value!;
                              });
                              getTaskStatus(status.name);
                            },
                          ),
                          Text(
                            "Running",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Radio(
                            value: TaskStatus.Pause,
                            groupValue: status,
                            onChanged: (TaskStatus? value) {
                              setState(() {
                                status = value!;
                              });
                              getTaskStatus(status.name);
                            },
                          ),
                          Text(
                            "Pause",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Radio(
                            value: TaskStatus.Completed,
                            groupValue: status,
                            onChanged: (TaskStatus? value) {
                              setState(() {
                                status = value!;
                              });
                              getTaskStatus(status.name);
                            },
                          ),
                          Text(
                            "Completed",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  openBottomSheet() {
    return showModalBottomSheet<void>(
      backgroundColor: Theme.of(context).cardColor,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: 460,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(30)),
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Create Todo',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Todo Title',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              style: TextStyle(color: blackColor),
                              controller: titleController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter title";
                                }
                              },
                              decoration: InputDecoration(
                                  fillColor: lightGrayColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'Enter task title'),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Description',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              style: TextStyle(color: blackColor),
                              controller: descController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Description";
                                }
                              },
                              decoration: InputDecoration(
                                  fillColor: lightGrayColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'Enter task description'),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Timer',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              style: TextStyle(color: blackColor),
                              controller: timerController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter time";
                                }
                              },
                              decoration: InputDecoration(
                                  fillColor: lightGrayColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'Enter task timer'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                await updateTask();
                                Navigator.of(context).pop();
                              }
                            },
                            child: Container(
                              height: 50,
                              width: width / 2 - 50,
                              decoration: BoxDecoration(
                                color: purpleColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                      color: whiteColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: 50,
                              width: width / 2 - 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: purpleColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: purpleColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                      // ElevatedButton(onPressed: (){}, child: Text('Create Task'))
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
