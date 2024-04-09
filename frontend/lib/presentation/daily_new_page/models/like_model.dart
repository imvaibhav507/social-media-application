import '../../../core/app_export.dart';

class LikeModel {
  int? statusCode;
  Rx<PostLikedModel>? postLikedModel;
  String? message;
  bool? success;

  LikeModel({this.statusCode, this.postLikedModel, this.message, this.success});

  LikeModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    postLikedModel = json['data'] != null ? Rx(new PostLikedModel.fromJson(json['data']) ): null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.postLikedModel != null) {
      data['data'] = this.postLikedModel!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class PostLikedModel {
  String? likedBy;
  String? postLiked;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PostLikedModel(
      {this.likedBy,
        this.postLiked,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  PostLikedModel.fromJson(Map<String, dynamic> json) {
    likedBy = json['likedBy'];
    postLiked = json['postLiked'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['likedBy'] = this.likedBy;
    data['postLiked'] = this.postLiked;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
