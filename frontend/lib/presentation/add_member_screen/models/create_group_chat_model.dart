class NewGroupChatModel {
  String? name;
  List<String?> participants = <String?>[];

  NewGroupChatModel({this.name,required this.participants});

  NewGroupChatModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    participants = json['participants'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['participants'] = this.participants;
    return data;
  }
}
