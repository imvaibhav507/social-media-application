import 'package:get/get.dart';
class StoriesListModel {
  int? statusCode;
  RxList<StoriesListItemModel>? storiesListModel;
  String? message;
  bool? success;

  StoriesListModel({this.statusCode, this.storiesListModel, this.message, this.success});

  StoriesListModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      storiesListModel = RxList(<StoriesListItemModel>[]);
      json['data'].forEach((v) {
        storiesListModel!.add(new StoriesListItemModel.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.storiesListModel != null) {
      data['data'] = this.storiesListModel!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class StoriesListItemModel {
  String? sId;
  String? fullname;
  String? avatar;
  String? cover;

  StoriesListItemModel({this.sId, this.fullname, this.avatar, this.cover});

  StoriesListItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullname = json['fullname'];
    avatar = json['avatar'];
    cover = json['cover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullname'] = this.fullname;
    data['avatar'] = this.avatar;
    data['cover'] = this.cover;
    return data;
  }
}

