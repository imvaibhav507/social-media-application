import '../../../core/app_export.dart';

class SearchChatroomModel {
  int? statusCode;
  RxList<FoundChatroom>? foundChatrooms;
  String? message;
  bool? success;

  SearchChatroomModel({this.statusCode, this.foundChatrooms, this.message, this.success});

  SearchChatroomModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      foundChatrooms = RxList(<FoundChatroom>[]);
      json['data'].forEach((v) {
        foundChatrooms!.add(new FoundChatroom.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.foundChatrooms != null) {
      data['data'] = this.foundChatrooms!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class FoundChatroom {
  RxString? sId;
  RxString? name;
  RxString? avatar;
  RxBool? isGroupChat;
  RxList<Member>? members;

  FoundChatroom({this.sId, this.name, this.avatar, this.isGroupChat, this.members});

  FoundChatroom.fromJson(Map<String, dynamic> json) {
    sId = RxString(json['_id']);
    name = RxString(json['name']);
    avatar = RxString(json['avatar']);
    isGroupChat = RxBool(json['isGroupChat']);
    if (json['members'] != null) {
      members = RxList(<Member>[]);
      json['members'].forEach((v) {
        members!.add(new Member.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['isGroupChat'] = this.isGroupChat;
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Member {
  String? sId;
  String? username;
  String? fullname;

  Member({this.sId, this.username, this.fullname});

  Member.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    fullname = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    return data;
  }
}
