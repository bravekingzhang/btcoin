import 'package:flutter/material.dart';

class Mine extends StatefulWidget {
  @override
  _MineState createState() => _MineState();
}

class _MineState extends State<Mine> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("我的"),
        ),
        body: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/register');
          },
          child: new Center(child: new Text("我的页面")),
        ));
  }
}
