/// This class defines the variables used in the [log_in_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class LoginModel {
  String? email;
  String? password;

  LoginModel({this.email, this.password});

  LoginModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
