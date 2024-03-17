class TokenModel {
  int? statusCode;
  Tokens? tokens;
  String? message;
  bool? success;

  TokenModel({this.statusCode, this.tokens, this.message, this.success});

  TokenModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    tokens =
    json['tokens'] != null ? new Tokens.fromJson(json['tokens']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    if (this.tokens != null) {
      data['tokens'] = this.tokens!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Tokens {
  String? userId;
  String? accessToken;
  String? refreshToken;

  Tokens({this.userId, this.accessToken, this.refreshToken});

  Tokens.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}
