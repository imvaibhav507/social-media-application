import 'package:get/get.dart';

class FollowersListModel {
  int? statusCode;
  RxList<FollowerModel>? followersListModel;
  String? message;
  bool? success;

  FollowersListModel({this.statusCode, this.followersListModel, this.message, this.success});

  FollowersListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      followersListModel = RxList(<FollowerModel>[]);
      json['data'].forEach((v) {
        followersListModel!.add(new FollowerModel.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.followersListModel != null) {
      data['data'] = this.followersListModel!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class FollowerModel {
  String? sId;
  String? userId;
  String? name;
  String? username;
  String? avatar;

  FollowerModel({this.sId, this.userId, this.name, this.username, this.avatar});

  FollowerModel.fromJson(Map<String, dynamic> json) {
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
