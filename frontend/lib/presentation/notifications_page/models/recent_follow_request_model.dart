import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class RecentFollowRequestModel {
  int? statusCode;
  Rx<RecentRequestModel>? recentRequestModelObj;
  String? message;
  bool? success;

  RecentFollowRequestModel(
      {this.statusCode, this.recentRequestModelObj, this.message, this.success});

  RecentFollowRequestModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    recentRequestModelObj = json['data'] != null ? Rx(new RecentRequestModel.fromJson(json['data'])) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.recentRequestModelObj != null) {
      data['data'] = this.recentRequestModelObj!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class RecentRequestModel {
  RxString? username;
  RxList<String>? avatars;
  RxInt? count;

  RecentRequestModel({this.username, this.avatars, this.count});

  RecentRequestModel.fromJson(Map<String, dynamic> json) {
    username = RxString(json['username']);
    avatars = RxList(json['avatars'].cast<String>());
    count = RxInt(json['count']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['avatars'] = this.avatars;
    data['count'] = this.count;
    return data;
  }
}
