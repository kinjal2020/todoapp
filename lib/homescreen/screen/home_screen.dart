import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/homescreen/provider/todo_provider.dart';
import 'package:todoapp/homescreen/widget/single_task_screen.dart';

import '../../../model/todo_model.dart';
import '../../../utils/colors.dart';
import '../../detailscreen/details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController timerController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  saveTask() async {
    final providerVar = Provider.of<TodoProvider>(context, listen: false);
    await providerVar.addTask(titleController.text, descController.text,
        'Created', timerController.text);
  }

  @override
  void initState() {
    // TODO: implement initState
    getTask();
    super.initState();
  }

  getTask() {
    final providerVar = Provider.of<TodoProvider>(context, listen: false);
    providerVar.getTaskList();
  }

  searchTask() {
    final providerVar = Provider.of<TodoProvider>(context, listen: false);
    providerVar.searchTask(searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    final providerVar = Provider.of<TodoProvider>(context, listen: true);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(
            'Todo App',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          actions: [
            Switch(
                value: providerVar.themeStatus,
                onChanged: (value) {
                  providerVar.themeStatus = value;
                })
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Todos',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    InkWell(
                      onTap: () {
                        openBottomSheet();
                      },
                      child: Container(
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                            color: orangeColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            '+ Add Todo',
                            style: TextStyle(
                                color: whiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  //height: 60,
                  decoration: BoxDecoration(
                      color: lightGrayColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      style: TextStyle(color: blackColor),
                      controller: searchController,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          getTask();
                        }
                      },
                      onFieldSubmitted: (value) {
                        if (value.isNotEmpty) {
                          searchTask();
                        }
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search Todo based on title',
                          suffixIcon: IconButton(
                            onPressed: () {
                              if (searchController.text.isNotEmpty) {
                                searchTask();
                              }
                            },
                            icon: Icon(Icons.search_outlined),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: height - 250,
                  child: (providerVar.todoList.isEmpty)
                      ? Center(
                          child: Text(
                          'Todo List is Empty',
                          style: Theme.of(context).textTheme.titleLarge,
                        ))
                      : ListView.builder(
                          itemCount: providerVar.todoList.length,
                          itemBuilder: (context, index) {
                            return SingleTaskScreen(
                                todo: providerVar.todoList[index]);
                          }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  openBottomSheet() {
    timerController.clear();
    titleController.clear();
    descController.clear();
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
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(30)),
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
                              keyboardType: TextInputType.number,
                              controller: timerController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter time";
                                } else if (int.parse(timerController.text) >
                                    5) {
                                  return "Up to 5 min";
                                }
                              },
                              decoration: InputDecoration(
                                  fillColor: lightGrayColor,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'Enter task timer(In Minutes)'),
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
                                await saveTask();
                                getTask();
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
