import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'trans.dart';
import 'order.dart';
import 'wallet.dart';
import 'mine.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Trans mTrans;
  Order mOrder;
  Wallet mWallet;
  Mine mine;

  int _currentIndex = 0;

  void _addTrans() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new CupertinoTabScaffold(
      tabBar: new CupertinoTabBar(
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.traffic),
            title: new Text("交易"),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.reorder),
            title: new Text("订单"),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.cached),
            title: new Text("钱包"),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.people),
            title: new Text("我的"),
          )
        ],
        currentIndex: _currentIndex,
      ),
      tabBuilder: buildPage,
    );
  }

  Widget buildPage(context, index) {
    switch (index) {
      case 1:
        if (mOrder == null) {
          mOrder = Order();
        }
        return mOrder;
      case 2:
        if (mWallet == null) {
          mWallet = Wallet();
        }
        return mWallet;
      case 3:
        if (mine == null) {
          mine = Mine();
        }
        return mine;
      default:
        if (mTrans == null) {
          mTrans = Trans(
            content: "交易列表页",
          );
        }
        return mTrans;
    }
  }
}
