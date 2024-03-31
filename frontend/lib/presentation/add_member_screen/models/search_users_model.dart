import 'package:get/get.dart';

class SearchUsersModel {
  int? statusCode;
  RxList<User>? users;
  String? message;
  bool? success;

  SearchUsersModel({this.statusCode, this.users, this.message, this.success});

  SearchUsersModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      users = RxList(<User>[]);
      json['data'].forEach((v) {
        users!.add(new User.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.users != null) {
      data['data'] = this.users!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class User {
  String? sId;
  String? username;
  String? fullName;
  String? avatar;
  bool? isAdded;

  User({this.sId, this.username, this.fullName, this.avatar, this.isAdded});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    fullName = json['fullName'];
    avatar = json['avatar'];
    isAdded = json['isAdded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['fullName'] = this.fullName;
    data['avatar'] = this.avatar;
    data['isAdded'] = this.isAdded;
    return data;
  }
}
