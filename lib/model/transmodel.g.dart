// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransModel _$TransModelFromJson(Map<String, dynamic> json) {
  return new TransModel(
      uid: json['uid'] as String,
      head: json['head'] as String,
      name: json['name'] as String,
      type: json['type'] as int,
      transSuccNum: json['trans_succ_num'] as int,
      comment: (json['comment'] as num).toDouble(),
      relay: json['relay'] as int,
      limitHigh: json['limit_hight'] as int,
      limitLow: json['limit_low'] as int,
      curTrans: (json['cur_trans'] as num).toDouble());
}

abstract class _$TransModelSerializerMixin {
  String get uid;
  String get head;
  String get name;
  int get type;
  int get transSuccNum;
  double get comment;
  int get relay;
  int get limitLow;
  int get limitHigh;
  double get curTrans;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'uid': uid,
        'head': head,
        'name': name,
        'type': type,
        'trans_succ_num': transSuccNum,
        'comment': comment,
        'relay': relay,
        'limit_low': limitLow,
        'limit_hight': limitHigh,
        'cur_trans': curTrans
      };
}
