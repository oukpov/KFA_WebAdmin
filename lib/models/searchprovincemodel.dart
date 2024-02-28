class DataModel {
  int? propertyTypeId;
  String? nameCummune;

  DataModel({this.propertyTypeId, this.nameCummune});

  DataModel.fromJson(Map<String, dynamic> json) {
    propertyTypeId = json['property_type_id'];
    nameCummune = json['Name_cummune'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['property_type_id'] = this.propertyTypeId;
    data['Name_cummune'] = this.nameCummune;
    return data;
  }
}