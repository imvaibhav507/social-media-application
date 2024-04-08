import 'package:get/get.dart';

class PostsModel {
  int? statusCode;
  RxList<Post>? posts;
  String? message;
  bool? success;

  PostsModel({this.statusCode, this.posts, this.message, this.success});

  PostsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      posts = RxList(<Post>[]);
      json['data'].forEach((v) {
        posts!.add(new Post.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.posts != null) {
      data['data'] = this.posts!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Post {
  String? sId;
  String? caption;
  List<String>? attachments;
  Creator? creator;
  String? createdAt;

  Post(
      {this.sId, this.caption, this.attachments, this.creator, this.createdAt});

  Post.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    caption = json['caption'];
    attachments = json['attachments'].cast<String>();
    creator =
    json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['caption'] = this.caption;
    data['attachments'] = this.attachments;
    if (this.creator != null) {
      data['creator'] = this.creator!.toJson();
    }
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Creator {
  String? sId;
  String? username;
  String? fullName;
  String? avatar;

  Creator({this.sId, this.username, this.fullName, this.avatar});

  Creator.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    fullName = json['fullName'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['fullName'] = this.fullName;
    data['avatar'] = this.avatar;
    return data;
  }
}
