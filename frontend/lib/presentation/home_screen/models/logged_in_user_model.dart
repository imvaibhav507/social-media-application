class LoggedInUserModel {
  int? statusCode;
  Data? data;
  String? message;
  bool? success;

  LoggedInUserModel({this.statusCode, this.data, this.message, this.success});

  LoggedInUserModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  String? sId;
  String? username;
  String? email;
  String? avatar;
  String? dateOfBirth;
  String? gender;
  String? fullname;

  Data(
      {this.sId,
        this.username,
        this.email,
        this.avatar,
        this.dateOfBirth,
        this.gender,
        this.fullname});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    avatar = json['avatar'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    fullname = json['fullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['avatar'] = this.avatar;
    data['dateOfBirth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['fullname'] = this.fullname;
    return data;
  }
}
