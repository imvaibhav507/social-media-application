import 'package:vaibhav_s_application2/core/app_export.dart';

class ChatroomDetailsModel {
  Rx<int>? statusCode;
  Rx<ChatDetailsModel>? chatDetails;
  Rx<String>? message;
  Rx<bool>? success;

  ChatroomDetailsModel(
      {this.statusCode, this.chatDetails, this.message, this.success});

  ChatroomDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = Rx(json['statusCode']);
    chatDetails = json['data'] != null ? Rx(new ChatDetailsModel.fromJson(json['data'])) : null;
    message = Rx(json['message']);
    success = Rx(json['success']);
  }
}

class ChatDetailsModel {
  Rx<String>? sId;
  Rx<String>? name;
  Rx<String>? avatar;
  Rx<List<MemberDetails>>? memberDetails;

  ChatDetailsModel({this.sId, this.name, this.avatar, this.memberDetails});

  ChatDetailsModel.fromJson(Map<String, dynamic> json) {
    sId = Rx(json['_id']);
    name = Rx(json['name']);
    avatar = Rx(json['avatar']);
    if (json['memberDetails'] != null) {
      memberDetails = Rx(<MemberDetails>[]);
      json['memberDetails'].forEach((v) {
        memberDetails!.value.add(new MemberDetails.fromJson(v));
      });
    }
  }
}

class MemberDetails {
  Rx<String>? username;
  Rx<String>? email;
  Rx<String>? avatar;

  MemberDetails({this.username, this.email, this.avatar});

  MemberDetails.fromJson(Map<String, dynamic> json) {
    username = Rx(json['username']);
    email = Rx(json['email']);
    avatar = Rx(json['avatar']);
  }
}
