/// This class defines the variables used in the [for_you_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class StoryModel {
  int? statusCode;
  StoryItemModel? storyItemModel;
  String? message;
  bool? success;

  StoryModel({this.statusCode, this.storyItemModel, this.message, this.success});

  StoryModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    storyItemModel = json['data'] != null ? new StoryItemModel.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.storyItemModel != null) {
      data['data'] = this.storyItemModel!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class StoryItemModel {
  String? sId;
  List<String>? attachments;
  String? avatar;
  String? fullname;
  String? createdAt;

  StoryItemModel(
      {this.sId, this.attachments, this.avatar, this.fullname, this.createdAt});

  StoryItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    attachments = json['attachments'].cast<String>();
    avatar = json['avatar'];
    fullname = json['fullname'];
    createdAt = json['CreatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['attachments'] = this.attachments;
    data['avatar'] = this.avatar;
    data['fullname'] = this.fullname;
    data['CreatedAt'] = this.createdAt;
    return data;
  }
}

