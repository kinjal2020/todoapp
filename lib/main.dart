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
      child: Consumer<TodoProvider>(builder: (context, providerVar, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'Poppins',
            primarySwatch: Colors.deepOrange,
            backgroundColor: whiteColor,
            accentColor: orangeColor,
            cardColor: whiteColor,
            bottomAppBarColor: orangeColor,
            textTheme: TextTheme(
              titleLarge: TextStyle(color: blackColor),
              titleMedium: TextStyle(color: blackColor),
              titleSmall: TextStyle(color: blackColor),
            ),

          ),
          darkTheme: ThemeData(
            fontFamily: 'Poppins',
            primarySwatch: Colors.deepOrange,
            accentColor: darkContainerColor,
            cardColor: darkContainerColor,
            backgroundColor: darkBgColor,
            bottomAppBarColor: darkBgColor,
            textTheme: TextTheme(
              titleLarge: TextStyle(color: whiteColor),
              titleMedium: TextStyle(color: whiteColor),
              titleSmall: TextStyle(color: whiteColor),
            ),
          ),
          themeMode: providerVar.themeStatus == true
              ? ThemeMode.dark
              : ThemeMode.light,
          // home: TaskDetailsScreen(),
          home: HomeScreen(),
        );
      }),
    );
  }
}
