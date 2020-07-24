import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:coruscate_task/add_new_address.dart';
import 'package:coruscate_task/address_class.dart';
import 'package:coruscate_task/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Address Menu",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: HomeScreen(),
    );
  }
}