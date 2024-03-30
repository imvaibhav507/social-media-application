import '../../../core/app_export.dart';
import 'stories1_item_model.dart';
import 'messageslist_item_model.dart';

/// This class defines the variables used in the [messages_page],
/// and is typically used to hold data that is passed between different parts of the application.

class MessageslistModel {
  Rx<int>? statusCode;
  Rx<List<MessagesItemModel>>? messagesItems;
  Rx<String>? message;
  Rx<bool>? success;

  MessageslistModel(
      {this.statusCode, this.messagesItems, this.message, this.success});

  MessageslistModel.fromJson(Map<String, dynamic> json) {
    statusCode = Rx(json['statusCode']);
    if (json['data'] != null) {
      messagesItems = Rx(<MessagesItemModel>[]);
      json['data'].forEach((v) {
        messagesItems?.value.add(new MessagesItemModel.fromJson(v));
      });
    }
    message = Rx(json['message']);
    success = Rx(json['success']);
  }

}




