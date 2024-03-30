class SendMessageModel {
  String? chatroomId;
  String? message;

  SendMessageModel({this.chatroomId, this.message});

  SendMessageModel.fromJson(Map<String, dynamic> json) {
    chatroomId = json['chatroomId'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chatroomId'] = this.chatroomId;
    data['message'] = this.message;
    return data;
  }
}