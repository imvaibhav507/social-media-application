import 'package:get/get.dart';

/// This class defines the variables used in the [chat_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class ChatScreenModel {
  Rx<int>? statusCode;
  RxList<ChatModel>? chatItems;
  Rx<String>? message;
  Rx<bool>? success;

  ChatScreenModel({this.statusCode, this.chatItems, this.message, this.success});

  ChatScreenModel.fromJson(Map<String, dynamic> json) {
    statusCode = Rx(json['statusCode']);
    if (json['data'] != null) {
      chatItems = RxList(<ChatModel>[]);
      json['data'].forEach((v) {
        chatItems!.add(new ChatModel.fromJson(v));
      });
    }
    message = Rx(json['message']);
    success = Rx(json['success']);
  }
}

class ChatModel {
  Rx<String>? sId;
  Rx<String>? content;
  Rx<List<String>>? attachments;
  Rx<String>? name;
  Rx<String>? senderId;
  Rx<String>? time;
  Rx<String>? createdAt;

  ChatModel({this.sId, this.content, this.attachments, this.name, this.senderId, this.time});

  ChatModel.fromJson(Map<String, dynamic> json) {
    sId = Rx(json['_id']);
    content = Rx(json['content']);
    attachments = Rx(json['attachments'].cast<String>());
    name = Rx(json['name']);
    senderId = Rx(json['senderId']);
    time = Rx(json['time']);
    createdAt = Rx(json['createdAt']);
  }

}
