import 'dart:ui';

import 'package:api_http/dataBase.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      title: "SQL Database",
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController _controller;
  var jp;
  final dbhelper = Databasehelper.instance;
  void insertdata() async {
    Map<String, dynamic> row = {
      Databasehelper.columnName: _controller,
      Databasehelper.columnAge: 20
    };
    final id = await dbhelper.insert(row);
    print(id);
  }

  void queryall() async {
    var allrows = await dbhelper.queryall();
    allrows.forEach((row) {
      setState(() {
        jp = row;
      });
      print(row);
    });
  }

  void delete() async {
    var id = await dbhelper.deleteo(2);
    print(jp);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "SQL Database ",
          ),
          centerTitle: true,
        ),
        body: Column(
          // padding: EdgeInsets.fromLTRB(480, 150, 480, 300),
          children: [
            MaterialButton(
                color: Colors.blueGrey,
                child: Text("Insert"),
                onPressed: () {
                  insertdata();
                }),
            SizedBox(
              child: TextField(controller: _controller),
              height: 30,
            ),
            MaterialButton(
                color: Colors.red,
                child: Text("Query\search"),
                onPressed: () {
                  queryall();
                }),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
                color: Colors.yellow, child: Text("DELETE"), onPressed: () {}),
            SizedBox(
              height: 200,
              child: Text(
                  style: TextStyle(fontSize: 20, color: Colors.red),
                  jp.toString()),
            ),
          ],
        ));
  }
}
