
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
  RxString? sId;
  RxString? content;
  RxList<String>? attachments;
  RxString? name;
  RxString? senderId;
  RxString? time;
  RxString? createdAt;

  ChatModel({this.sId, this.content, this.attachments, this.name, this.senderId, this.time, this.createdAt});

  ChatModel.fromJson(Map<String, dynamic> json) {
    sId = RxString(json['_id']);
    content = RxString(json['content']);
    attachments = RxList(json['attachments'].cast<String>());
    name = RxString(json['name']);
    senderId = RxString(json['senderId']);
    time = RxString(json['time']);
    createdAt = RxString(json['createdAt']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId?.value;
    data['content'] = this.content?.value;
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v).toList();
    }
    data['senderId'] = this.senderId?.value;
    data['createdAt'] = this.createdAt?.value;
    return data;
  }
}

