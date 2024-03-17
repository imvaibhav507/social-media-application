class SignUpModel {
  String? fullName;
  String? email;
  String? username;
  String? password;
  String? dateOfBirth;

  SignUpModel(
      {this.fullName,
        this.email,
        this.username,
        this.password,
        this.dateOfBirth});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['username'] = this.username;
    data['password'] = this.password;
    data['dateOfBirth'] = this.dateOfBirth;
    return data;
  }
}
