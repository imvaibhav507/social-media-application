import '../../../core/app_export.dart';

/// This class is used in the [messageslist_item_widget] screen.
class MessagesItemModel {
  RxString? sId;
  RxString? name;
  RxString? lastMessage;
  RxString? avatar;
  RxList<String>? otherMembers;
  RxBool? isGroupChat;
  RxString? time;

  MessagesItemModel({this.sId, this.name,
    this.lastMessage, this.time, this.avatar,
    this.otherMembers, this.isGroupChat});

  MessagesItemModel.fromJson(Map<String, dynamic> json) {
    sId = RxString(json['_id']);
    name = RxString(json['name']);
    avatar = RxString(json['avatar']);
    lastMessage = (json['lastMessage']==null)? RxString("") : RxString(json['lastMessage']);
    otherMembers = RxList(json['otherMembers'].cast<String>());
    isGroupChat = RxBool(json['isGroupChat']);
    time = (json['time']==null)? RxString(""): RxString(json['time']);
  }
}
