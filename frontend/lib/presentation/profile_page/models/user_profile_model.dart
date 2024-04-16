class UserProfileModel {
  int? statusCode;
  ProfileDetails? profileDetails;
  String? message;
  bool? success;

  UserProfileModel({this.statusCode, this.profileDetails, this.message, this.success});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    profileDetails = json['data'] != null ? new ProfileDetails.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.profileDetails != null) {
      data['data'] = this.profileDetails!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class ProfileDetails {
  String? sId;
  String? username;
  String? avatar;
  int? postsCount;
  int? followings;
  int? followers;
  String? fullname;

  ProfileDetails(
      {this.sId,
        this.username,
        this.avatar,
        this.followings,
        this.followers,
        this.fullname});

  ProfileDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    avatar = json['avatar'];
    postsCount = json['postsCount'];
    followings = json['followings'];
    followers = json['followers'];
    fullname = json['fullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['postsCount'] = this.postsCount;
    data['followings'] = this.followings;
    data['followers'] = this.followers;
    data['fullname'] = this.fullname;
    return data;
  }
}
