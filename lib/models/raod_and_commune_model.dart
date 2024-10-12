class RoadAndCommnuneModel {
  String? cid;
  String? option;
  String? roadName;
  String? communeName;
  String? district;
  String? province;
  int? maxValue;
  int? minValue;
  double? longitude;
  double? latitude;

  RoadAndCommnuneModel(
      {this.cid,
      this.option,
      this.roadName,
      this.communeName,
      this.district,
      this.province,
      this.maxValue,
      this.minValue,
      this.longitude,
      this.latitude});

  RoadAndCommnuneModel.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    option = json['option'];
    roadName = json['road_name'];
    communeName = json['commune_name'];
    district = json['district'];
    province = json['province'];
    maxValue = json['max_value'];
    minValue = json['min_value'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this.cid;
    data['option'] = this.option;
    data['road_name'] = this.roadName;
    data['commune_name'] = this.communeName;
    data['district'] = this.district;
    data['province'] = this.province;
    data['max_value'] = this.maxValue;
    data['min_value'] = this.minValue;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}
