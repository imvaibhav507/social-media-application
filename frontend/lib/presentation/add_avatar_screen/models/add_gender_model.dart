class AddGenderModel {
  String? gender;

  AddGenderModel({this.gender});

  AddGenderModel.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    return data;
  }
}
