import 'dart:convert';
import 'package:coruscate_task/api.dart';
import 'package:coruscate_task/db_helper.dart';
import 'package:http/http.dart' as http;
import 'package:coruscate_task/add_new_address.dart';
import 'package:coruscate_task/address_class.dart';
import 'package:coruscate_task/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  ApiData ob = new ApiData();
  Future<List<AddressClass>> api_add;
  var dbHelper;

  void fetchData() async{
    List<AddressClass> add = await api_add;
    for(int i=0;i<add.length;i++){
      dbHelper.save(add[i]);
    }
  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    api_add =ob.getadvice();
    dbHelper = DBHelper();
    fetchData();
  }
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