class ResidincialModel {
  List<R>? r;

  ResidincialModel({this.r});

  ResidincialModel.fromJson(Map<String, dynamic> json) {
    if (json['r'] != null) {
      r = <R>[];
      json['r'].forEach((v) {
        r!.add(new R.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.r != null) {
      data['r'] = this.r!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class R {
  String? minValue;
  String? maxValue;
  int? khanID;
  int? sangkatID;

  R({this.minValue, this.maxValue, this.khanID, this.sangkatID});

  R.fromJson(Map<String, dynamic> json) {
    minValue = json['Min_Value'];
    maxValue = json['Max_Value'];
    khanID = json['Khan_ID'];
    sangkatID = json['Sangkat_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Min_Value'] = this.minValue;
    data['Max_Value'] = this.maxValue;
    data['Khan_ID'] = this.khanID;
    data['Sangkat_ID'] = this.sangkatID;
    return data;
  }
}
