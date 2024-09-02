class LandbuildingModels {
  int? verbalLandId;
  int? verbalLandid;
  String? verbalLandType;
  String? verbalLandDes;
  double? verbalLandArea;
  double? verbalLandMinsqm;
  double? verbalLandMaxsqm;
  double? verbalLandMinvalue;
  double? verbalLandMaxvalue;
  String? verbalImage;
  double? verbalLandPublished;
  String? verbalLandCreatedBy;
  String? verbalLandCreatedDate;
  String? verbalLandModifyBy;
  String? verbalLandModifyDate;
  String? address;
  String? typeValue;

  LandbuildingModels(
      {this.verbalLandId,
      this.verbalLandid,
      this.verbalLandType,
      this.verbalLandDes,
      this.verbalLandArea,
      this.verbalLandMinsqm,
      this.verbalLandMaxsqm,
      this.verbalLandMinvalue,
      this.verbalLandMaxvalue,
      this.verbalImage,
      this.verbalLandPublished,
      this.verbalLandCreatedBy,
      this.verbalLandCreatedDate,
      this.verbalLandModifyBy,
      this.verbalLandModifyDate,
      this.address,
      this.typeValue});

  LandbuildingModels.fromJson(Map<String, dynamic> json) {
    verbalLandId = json['verbal_land_id'];
    verbalLandid = json['verbal_landid'];
    verbalLandType = json['verbal_land_type'];
    verbalLandDes = json['verbal_land_des'];
    verbalLandArea = json['verbal_land_area'];
    verbalLandMinsqm = json['verbal_land_minsqm'];
    verbalLandMaxsqm = json['verbal_land_maxsqm'];
    verbalLandMinvalue = json['verbal_land_minvalue'];
    verbalLandMaxvalue = json['verbal_land_maxvalue'];
    verbalImage = json['verbal_image'];
    verbalLandPublished = json['verbal_land_published'];
    verbalLandCreatedBy = json['verbal_land_created_by'];
    verbalLandCreatedDate = json['verbal_land_created_date'];
    verbalLandModifyBy = json['verbal_land_modify_by'];
    verbalLandModifyDate = json['verbal_land_modify_date'];
    address = json['address'];
    typeValue = json['type_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['verbal_land_id'] = verbalLandId;
    data['verbal_landid'] = verbalLandid;
    data['verbal_land_type'] = verbalLandType;
    data['verbal_land_des'] = verbalLandDes;
    data['verbal_land_area'] = verbalLandArea;
    data['verbal_land_minsqm'] = verbalLandMinsqm;
    data['verbal_land_maxsqm'] = verbalLandMaxsqm;
    data['verbal_land_minvalue'] = verbalLandMinvalue;
    data['verbal_land_maxvalue'] = verbalLandMaxvalue;
    data['verbal_image'] = verbalImage;
    data['verbal_land_published'] = verbalLandPublished;
    data['verbal_land_created_by'] = verbalLandCreatedBy;
    data['verbal_land_created_date'] = verbalLandCreatedDate;
    data['verbal_land_modify_by'] = verbalLandModifyBy;
    data['verbal_land_modify_date'] = verbalLandModifyDate;
    data['address'] = address;
    data['type_value'] = typeValue;
    return data;
  }
}
