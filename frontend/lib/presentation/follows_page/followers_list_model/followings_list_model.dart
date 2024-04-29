import 'package:get/get.dart';

class FollowingsListModel {
  int? statusCode;
  RxList<FollowingModel>? followingsListModel;
  String? message;
  bool? success;

  FollowingsListModel({this.statusCode, this.followingsListModel, this.message, this.success});

  FollowingsListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      followingsListModel = RxList(<FollowingModel>[]);
      json['data'].forEach((v) {
        followingsListModel!.add(new FollowingModel.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.followingsListModel != null) {
      data['data'] = this.followingsListModel!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class FollowingModel {
  String? sId;
  String? userId;
  String? name;
  String? username;
  String? avatar;

  FollowingModel({this.sId, this.userId, this.name, this.username, this.avatar});

  FollowingModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    name = json['name'];
    username = json['username'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    return data;
  }
}
