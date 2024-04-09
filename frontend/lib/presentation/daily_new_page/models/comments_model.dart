import '../../../core/app_export.dart';
/// This class defines the variables used in the [comments_screen],
/// and is typically used to hold data that is passed between different parts of the application.

class CommentsModel {
  int? statusCode;
  RxList<CommentItemModel>? commentItemModelList;
  String? message;
  bool? success;

  CommentsModel({this.statusCode, this.commentItemModelList, this.message, this.success});

  CommentsModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      commentItemModelList = RxList(<CommentItemModel>[]);
      json['data'].forEach((v) {
        commentItemModelList!.add(new CommentItemModel.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.commentItemModelList != null) {
      data['data'] = this.commentItemModelList!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class CommentItemModel {
  String? sId;
  String? content;
  String? commentedBy;
  String? avatar;
  String? fullname;
  String? createdAt;

  CommentItemModel(
      {this.sId,
        this.content,
        this.commentedBy,
        this.avatar,
        this.fullname,
        this.createdAt});

  CommentItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    content = json['content'];
    commentedBy = json['commentedBy'];
    avatar = json['avatar'];
    fullname = json['fullname'];
    createdAt = json['CreatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['content'] = this.content;
    data['commentedBy'] = this.commentedBy;
    data['avatar'] = this.avatar;
    data['fullname'] = this.fullname;
    data['CreatedAt'] = this.createdAt;
    return data;
  }
}


class AddCommentModel {
  String? comment;
  String? postId;

  AddCommentModel({this.comment, this.postId});

  AddCommentModel.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    postId = json['postId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this.comment;
    data['postId'] = this.postId;
    return data;
  }
}

