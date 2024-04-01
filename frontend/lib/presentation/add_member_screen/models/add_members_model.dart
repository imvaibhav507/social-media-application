class AddMembersModel {
  String? chatroomId;
  List<String?> participants = <String?>[];

  AddMembersModel({this.chatroomId, required this.participants});

  AddMembersModel.fromJson(Map<String, dynamic> json) {
    chatroomId = json['chatroomId'];
    participants = json['participants'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chatroomId'] = this.chatroomId;
    data['participants'] = this.participants;
    return data;
  }
}
