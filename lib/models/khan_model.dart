class KhanModel {
  int? khanID;
  String? province;
  String? khanName;

  KhanModel({this.khanID, this.province, this.khanName});

  KhanModel.fromJson(Map<String, dynamic> json) {
    khanID = json['Khan_ID'];
    province = json['province'];
    khanName = json['Khan_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Khan_ID'] = this.khanID;
    data['province'] = this.province;
    data['Khan_Name'] = this.khanName;
    return data;
  }
}
