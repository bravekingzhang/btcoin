import 'package:flutter/material.dart';
import 'widget/segment.dart';
import 'package:dio/dio.dart';
import 'model/transmodel.dart';
import 'package:flutter/cupertino.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";

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
  double fontSize = 13.0;
  int _pageIndex = 0;
  List<TransModel> transList;
  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    //Called when this object is inserted into the tree.
    super.initState();
    _getData(true);
  }

  _getData(flag) async {
    //初始化数据
    Dio dio = new Dio();
    Response<dynamic> response = await dio.get(
        "https://easy-mock.com/mock/5b55bec0c566e657f2274628/btcoin/btc_list");
    List<TransModel> list = List();
    for (var value in response.data["data"]["list"]) {
      list.add(TransModel.fromJson(value));
    }
    setState(() {
      this.transList = list;
    });
    refreshController.sendBack(true, RefreshStatus.completed);
  }

  @override
  Widget build(BuildContext context) {
    final Map<int, Widget> children = const {
      0: Center(child: const Text('卖币', style: TextStyle(fontSize: 14.0))),
      1: Center(child: const Text('买币', style: TextStyle(fontSize: 14.0))),
    };
    return Scaffold(
      body: buildBody(),
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.only(left: 38.0, right: 38.0),
          child: SegmentedControl(
            children: children,
            onValueChanged: (pageIndex) {
              setState(() {
                this._pageIndex = pageIndex;
              });
            },
            groupValue: this._pageIndex,
          ),
        ),
      ),
    );
  }

  /**
   * 没有内容显示菊花，加载中，有内容突出内容，[升级版]加载失败，还可以重试，这里可以封装一个控件
   */
  Widget buildBody() {
    if (transList == null) {
      return Center(child: CupertinoActivityIndicator());
    } else {
      return SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          enablePullUp: false,
          onRefresh: _getData,
          child: ListView.builder(
              itemCount: transList == null ? 0 : transList.length,
              itemBuilder: buildList));
    }
  }

  Widget buildList(context, index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 55.0,
            height: 55.0,
            margin: EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
                backgroundImage: NetworkImage(transList[index].head)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      transList[index].name,
                      style: TextStyle(
                          fontSize: fontSize, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 3.0),
                      decoration: BoxDecoration(color: Colors.green.shade700),
                      padding: const EdgeInsets.only(
                          top: 2.0, bottom: 2.0, left: 1.0, right: 1.0),
                      child: Text(
                        getCashType(transList[index].type),
                        style:
                            TextStyle(fontSize: fontSize, color: Colors.white),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                  child: Text(
                    '交易 ${transList[index].transSuccNum} | 好评 ${transList[index].comment}% | 信任 ${transList[index].relay}',
                    style: TextStyle(
                        fontSize: fontSize, color: Colors.grey.shade500),
                  ),
                ),
                Text(
                  '限额 ${transList[index].limitLow}-${transList[index].limitHigh} CNY',
                  style: TextStyle(
                      fontSize: fontSize, color: Colors.grey.shade500),
                )
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Text(
                '${transList[index].curTrans} CNY',
                style:
                    TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.all(2.0),
                margin: EdgeInsets.only(top: 4.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.lightBlue, width: 1.0)),
                child: Text(
                  '购买 BTC',
                  style: TextStyle(fontSize: fontSize, color: Colors.lightBlue),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  String getCashType(int type) {
    switch (type) {
      case 1:
        return "微信支付";
      case 2:
        return "银行转账";
      case 3:
        return "支付宝";
      default:
        return "现金存款";
    }
  }
}
