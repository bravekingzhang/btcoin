import 'package:flutter/material.dart';

class SegmentView extends StatefulWidget {
  final String title1;
  final String title2;
  final ValueChanged<int> onIndexChange;

  const SegmentView({Key key, this.title1, this.title2, this.onIndexChange})
      : super(key: key);

  @override
  _SegmentViewState createState() {
    return new _SegmentViewState();
  }
}

class _SegmentViewState extends State<SegmentView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0),
          decoration: BoxDecoration(
              color: currentIndex == 0 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3.0),
                  bottomLeft: Radius.circular(3.0)),
              border: Border(
                  top: BorderSide(color: Colors.white),
                  right: BorderSide(color: Colors.white),
                  bottom: BorderSide(color: Colors.white),
                  left: BorderSide(color: Colors.white))),
          child: GestureDetector(
            onTap: () {
              setState(() {
                currentIndex = 0;
              });
              this.widget.onIndexChange(0);
            },
            child: new Text(
              this.widget.title1,
              style: TextStyle(
                  fontSize: 16.0,
                  color: currentIndex == 0 ? Colors.blue : Colors.white),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0),
          decoration: BoxDecoration(
              color: currentIndex == 1 ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(3.0),
                  bottomRight: Radius.circular(3.0)),
              border: Border(
                  top: BorderSide(color: Colors.white),
                  right: BorderSide(color: Colors.white),
                  bottom: BorderSide(color: Colors.white),
                  left: BorderSide(color: Colors.white))),
          child: GestureDetector(
            onTap: () {
              setState(() {
                currentIndex = 1;
              });
              this.widget.onIndexChange(1);
            },
            child: new Text(
              this.widget.title2,
              style: TextStyle(
                  fontSize: 16.0,
                  color: currentIndex == 1 ? Colors.blue : Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
