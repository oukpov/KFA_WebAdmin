class ComparableReponseModel {
  final String message;
  final String access_token;
  ComparableReponseModel({
    required this.message,
    required this.access_token,
  });
  factory ComparableReponseModel.fromJson(Map<String, dynamic> json) {
    return ComparableReponseModel(
      message: json["message"] ?? "",
      access_token: json["access_token"] ?? "",
    );
  }
}

class SavenewcomparableModel {
  late String bankinfo;
  late String propertytype;
  late String skc;
  late String date;
  late String condition;
  late String surveydate;
  late String ownerphone;
  late String latittute;
  late String longtittute;
  SavenewcomparableModel({
    required this.bankinfo,
    required this.propertytype,
    required this.skc,
    required this.condition,
    required this.surveydate,
    required this.ownerphone,
    required this.latittute,
    required this.longtittute,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "bankinfo": bankinfo.trim(),
      "propertytype": propertytype.trim(),
      "skc": skc,
      "date": date.trim(),
      "condition": condition.trim(),
      "surveydate": surveydate.trim(),
      "ownerphone": ownerphone.trim(),
      "latittute": latittute.trim(),
      "longtittute": longtittute.trim(),
    };
    return map;
  }
}
