import 'package:get/get.dart';

class SearchedUserProfilesModel {
  int? statusCode;
  RxList<FoundUserProfileModel>? foundUserProfile;
  String? message;
  bool? success;

  SearchedUserProfilesModel(
      {this.statusCode, this.foundUserProfile, this.message, this.success});

  SearchedUserProfilesModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      foundUserProfile = RxList(<FoundUserProfileModel>[]);
      json['data'].forEach((v) {
        foundUserProfile!.add(new FoundUserProfileModel.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.foundUserProfile != null) {
      data['data'] = this.foundUserProfile!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class FoundUserProfileModel {
  String? sId;
  String? username;
  String? avatar;
  String? fullname;
  bool? followedByYou;

  FoundUserProfileModel({this.sId, this.username, this.avatar, this.fullname, this.followedByYou});

  FoundUserProfileModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    avatar = json['avatar'];
    fullname = json['fullname'];
    followedByYou = json['followedByYou'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['fullname'] = this.fullname;
    data['followedByYou'] = this.followedByYou;
    return data;
  }
}
