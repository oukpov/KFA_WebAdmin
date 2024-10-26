class ComercialModel {
  List<C>? c;

  ComercialModel({this.c});

  ComercialModel.fromJson(Map<String, dynamic> json) {
    if (json['c'] != null) {
      c = <C>[];
      json['c'].forEach((v) {
        c!.add(new C.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.c != null) {
      data['c'] = this.c!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class C {
  String? minValue;
  String? maxValue;
  int? khanID;
  int? sangkatID;

  C({this.minValue, this.maxValue, this.khanID, this.sangkatID});

  C.fromJson(Map<String, dynamic> json) {
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
