class ChatroomIdModel {
  int? statusCode;
  String? chatroomId;
  String? message;
  bool? success;

  ChatroomIdModel({this.statusCode, this.chatroomId, this.message, this.success});

  ChatroomIdModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    chatroomId = json['data'];
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['data'] = this.chatroomId;
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}
