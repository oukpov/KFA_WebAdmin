class ComercialAndResidencialModel {
  int? khanID;
  int? sangkatID;
  String? province;
  String? khanName;
  String? sangkatName;
  String? residentialMinValue;
  String? residentialMaxValue;
  String? commercialMinValue;
  String? commercialMaxValue;

  ComercialAndResidencialModel(
      {this.khanID,
      this.sangkatID,
      this.province,
      this.khanName,
      this.sangkatName,
      this.residentialMinValue,
      this.residentialMaxValue,
      this.commercialMinValue,
      this.commercialMaxValue});

  ComercialAndResidencialModel.fromJson(Map<String, dynamic> json) {
    khanID = json['Khan_ID'];
    sangkatID = json['Sangkat_ID'];
    province = json['province'];
    khanName = json['Khan_Name'];
    sangkatName = json['Sangkat_Name'];
    residentialMinValue = json['residential_min_value'];
    residentialMaxValue = json['residential_max_value'];
    commercialMinValue = json['commercial_min_value'];
    commercialMaxValue = json['commercial_max_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Khan_ID'] = this.khanID;
    data['Sangkat_ID'] = this.sangkatID;
    data['province'] = this.province;
    data['Khan_Name'] = this.khanName;
    data['Sangkat_Name'] = this.sangkatName;
    data['residential_min_value'] = this.residentialMinValue;
    data['residential_max_value'] = this.residentialMaxValue;
    data['commercial_min_value'] = this.commercialMinValue;
    data['commercial_max_value'] = this.commercialMaxValue;
    return data;
  }
}
