import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todoapp/model/todo_model.dart';

import 'package:todoapp/utils/colors.dart';
import 'detailscreen/details_screen.dart';
import 'homescreen/screen/home_screen.dart';
import 'homescreen/provider/todo_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => TodoProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Poppins',
          primarySwatch: Colors.deepOrange,
        ),
        // home: TaskDetailsScreen(),
        home: HomeScreen(),
      ),
    );
  }
}
