class Verbal_limited {
  String? idVerbal;
  String? idLimitedVerbal;
  String? numberLimited;
  String? block;

  Verbal_limited(
      {this.idVerbal, this.idLimitedVerbal, this.numberLimited, this.block});

  Verbal_limited.fromJson(Map<String, dynamic> json) {
    idVerbal = json['id_verbal'];
    idLimitedVerbal = json['id_limited_verbal'];
    numberLimited = json['number_limited'];
    block = json['block'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_verbal'] = this.idVerbal;
    data['id_limited_verbal'] = this.idLimitedVerbal;
    data['number_limited'] = this.numberLimited;
    data['block'] = this.block;
    return data;
  }
}

class Verbal_limited_ReponeModel {
  final String message;
  Verbal_limited_ReponeModel({
    required this.message,
  });
  factory Verbal_limited_ReponeModel.fromJson(Map<String, dynamic> json) {
    return Verbal_limited_ReponeModel(
      message: json["message"] ?? "",
    );
  }
}
