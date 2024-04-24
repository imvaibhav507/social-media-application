class PersonalChatDetailsModel {
  int? statusCode;
  MemberDetailsModel? memberDetailsModel;
  String? message;
  bool? success;

  PersonalChatDetailsModel(
      {this.statusCode, this.memberDetailsModel, this.message, this.success});

  PersonalChatDetailsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    memberDetailsModel = json['data'] != null ? new MemberDetailsModel.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.memberDetailsModel != null) {
      data['data'] = this.memberDetailsModel!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class MemberDetailsModel {
  String? sId;
  String? name;
  String? avatar;
  String? username;
  String? email;

  MemberDetailsModel({this.sId, this.name, this.avatar, this.username, this.email});

  MemberDetailsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    avatar = json['avatar'];
    username = json['username'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['username'] = this.username;
    data['email'] = this.email;
    return data;
  }
}
