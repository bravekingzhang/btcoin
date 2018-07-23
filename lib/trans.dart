import 'package:flutter/material.dart';
import 'widget/segment.dart';

/**
 * 交易列表页面
 */
class Trans extends StatefulWidget {
  final String content;

  const Trans({Key key, this.content}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Trans> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: SegmentView(
              title1: "卖币",
              title2: "买币",
              onIndexChange: (index) {
                setState(() {
                  this._pageIndex = index;
                });
              })),
      body: new Center(child: new Text('${widget.content}--$_pageIndex')),
    );
  }
}
