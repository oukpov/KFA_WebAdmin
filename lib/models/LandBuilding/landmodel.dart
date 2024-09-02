class LandbuildingModel {
  String? verbalLandType;
  String? verbalLandDes;
  String? verbalLandDp;
  String? verbalLandArea;
  String? verbalLandMinsqm;
  String? verbalLandMaxsqm;
  String? verbalLandMinvalue;
  String? verbalLandMaxvalue;
  String? address;
  String? verbalLandid;

  LandbuildingModel(
      {this.verbalLandType,
      this.verbalLandDes,
      this.verbalLandDp,
      this.verbalLandArea,
      this.verbalLandMinsqm,
      this.verbalLandMaxsqm,
      this.verbalLandMinvalue,
      this.verbalLandMaxvalue,
      this.address,
      this.verbalLandid});

  LandbuildingModel.fromJson(Map<String, dynamic> json) {
    verbalLandType = json['verbal_land_type'];
    verbalLandDes = json['verbal_land_des'];
    verbalLandDp = json['verbal_land_dp'];
    verbalLandArea = json['verbal_land_area'];
    verbalLandMinsqm = json['verbal_land_minsqm'];
    verbalLandMaxsqm = json['verbal_land_maxsqm'];
    verbalLandMinvalue = json['verbal_land_minvalue'];
    verbalLandMaxvalue = json['verbal_land_maxvalue'];
    address = json['address'];
    verbalLandid = json['verbal_landid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['verbal_land_type'] = verbalLandType;
    data['verbal_land_des'] = verbalLandDes;
    data['verbal_land_dp'] = verbalLandDp;
    data['verbal_land_area'] = verbalLandArea;
    data['verbal_land_minsqm'] = verbalLandMinsqm;
    data['verbal_land_maxsqm'] = verbalLandMaxsqm;
    data['verbal_land_minvalue'] = verbalLandMinvalue;
    data['verbal_land_maxvalue'] = verbalLandMaxvalue;
    data['address'] = address;
    data['verbal_landid'] = verbalLandid;
    return data;
  }
}
