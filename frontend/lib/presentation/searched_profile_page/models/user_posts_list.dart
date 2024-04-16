class UserPostsList {
  int? statusCode;
  List<PostListItemModel>? userPostsList;
  String? message;
  bool? success;

  UserPostsList({this.statusCode, this.userPostsList, this.message, this.success});

  UserPostsList.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      userPostsList = <PostListItemModel>[];
      json['data'].forEach((v) {
        userPostsList!.add(new PostListItemModel.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.userPostsList != null) {
      data['data'] = this.userPostsList!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class PostListItemModel {
  String? sId;
  bool? isMultiPost;
  String? cover;

  PostListItemModel({this.sId, this.isMultiPost, this.cover});

  PostListItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isMultiPost = json['isMultiPost'];
    cover = json['cover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['isMultiPost'] = this.isMultiPost;
    data['cover'] = this.cover;
    return data;
  }
}
