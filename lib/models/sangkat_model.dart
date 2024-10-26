class SangkatModel {
  int? sangkatID;
  String? sangkatName;

  SangkatModel({this.sangkatID, this.sangkatName});

  SangkatModel.fromJson(Map<String, dynamic> json) {
    sangkatID = json['Sangkat_ID'];
    sangkatName = json['Sangkat_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Sangkat_ID'] = this.sangkatID;
    data['Sangkat_Name'] = this.sangkatName;
    return data;
  }
}
