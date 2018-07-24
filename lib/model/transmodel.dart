///{uid: qVkc]zyPZpggefY, head: http://dummyimage.com/200x200, name: j^4DF1Q#UqY@, type: 3, trans_succ_num: 68, comment: 91.74, relay: 53, limit_low: 489, limit_hight: 981, cur_trans: 70.12
import 'package:json_annotation/json_annotation.dart';

part 'transmodel.g.dart';

@JsonSerializable(nullable: false)
class TransModel extends Object with _$TransModelSerializerMixin {
  TransModel(
      {this.uid,
      this.head,
      this.name,
      this.type,
      this.transSuccNum,
      this.comment,
      this.relay,
      this.limitHigh,
      this.limitLow,
      this.curTrans});

  String uid;
  String head;
  String name;
  int type;
  @JsonKey(name: 'trans_succ_num')
  int transSuccNum;
  double comment;
  int relay;
  @JsonKey(name: 'limit_low')
  int limitLow;
  @JsonKey(name: 'limit_hight')
  int limitHigh;
  @JsonKey(name: 'cur_trans')
  double curTrans;

  factory TransModel.fromJson(Map<String, dynamic> json) =>
      _$TransModelFromJson(json);
}
