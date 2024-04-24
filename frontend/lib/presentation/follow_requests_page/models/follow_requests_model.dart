import 'package:get/get.dart';

class FollowRequestsModel {
  int? statusCode;
  RxList<FollowRequestItemModel>? followRequestsList;
  String? message;
  bool? success;

  FollowRequestsModel({this.statusCode, this.followRequestsList, this.message, this.success});

  FollowRequestsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      followRequestsList = RxList(<FollowRequestItemModel>[]);
      json['data'].forEach((v) {
        followRequestsList!.add(new FollowRequestItemModel.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.followRequestsList != null) {
      data['data'] = this.followRequestsList!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class FollowRequestItemModel {
  String? sId;
  String? userId;
  String? name;
  String? username;
  String? avatar;

  FollowRequestItemModel({this.sId, this.userId, this.name, this.username, this.avatar});

  FollowRequestItemModel.fromJson(Map<String, dynamic> json) {
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
