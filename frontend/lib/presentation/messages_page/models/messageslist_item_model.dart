import '../../../core/app_export.dart';

/// This class is used in the [messageslist_item_widget] screen.
class MessagesItemModel {
  Rx<String>? sId;
  Rx<String>? name;
  Rx<String>? lastMessage;
  Rx<String>? avatar;
  Rx<String>? time;

  MessagesItemModel({this.sId, this.name, this.lastMessage, this.time, this.avatar});

  MessagesItemModel.fromJson(Map<String, dynamic> json) {
    sId = Rx(json['_id']);
    name = Rx(json['name']);
    avatar = Rx(json['avatar']);
    lastMessage = (json['lastMessage']==null)? Rx("") : Rx(json['lastMessage']);
    time = (json['time']==null)? Rx(""): Rx(json['time']);
  }
}
