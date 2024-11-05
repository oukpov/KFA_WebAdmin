class VerbalAgentModel {
  String? verbalId;
  String? verbalCode;
  String? titleDeedN;
  String? underPropertyRight;
  String? referrenceN;
  String? issuedDate;
  String? verbalPropertyId;
  String? verbalOwner;
  String? verbalContact;
  dynamic verbalDate;
  dynamic receivedate;
  String? verbalAddress;
  String? verbalComment;
  String? totalMin;
  String? totalMax;
  String? verbalImage;
  String? latlongLog;
  String? latlongLa;
  String? verbalStatusId;
  String? verbalPublished;
  String? verbalUser;
  String? verbalCreatedDate;
  void clear() {
    verbalId = null;
    verbalCode = null;
    titleDeedN = null;
    underPropertyRight = null;
    referrenceN = null;
    issuedDate = null;
    verbalPropertyId = null;
    verbalOwner = null;
    verbalContact = null;
    verbalDate = null;
    receivedate = null;
    verbalAddress = null;
    verbalComment = null;
    totalMin = null;
    totalMax = null;
    verbalImage = null;
    latlongLog = null;
    latlongLa = null;
    verbalStatusId = null;
    verbalPublished = null;
    verbalUser = null;
    verbalCreatedDate = null;
  }

  VerbalAgentModel({
    this.verbalId,
    this.verbalCode,
    this.titleDeedN,
    this.underPropertyRight,
    this.referrenceN,
    this.issuedDate,
    this.verbalPropertyId,
    this.verbalOwner,
    this.verbalContact,
    this.verbalDate,
    this.receivedate,
    this.verbalAddress,
    this.verbalComment,
    this.totalMin,
    this.totalMax,
    this.verbalImage,
    this.latlongLog,
    this.latlongLa,
    this.verbalStatusId,
    this.verbalPublished,
    this.verbalUser,
    this.verbalCreatedDate,
  });

  factory VerbalAgentModel.fromJson(Map<String?, dynamic> json) =>
      VerbalAgentModel(
        verbalId: json["verbal_id"],
        verbalCode: json["verbal_code"],
        titleDeedN: json["title_deedN"],
        underPropertyRight: json["under_property_right"],
        referrenceN: json["referrenceN"],
        issuedDate: json["issued_date"],
        verbalPropertyId: json["verbal_property_id"],
        verbalOwner: json["verbal_owner"],
        verbalContact: json["verbal_contact"],
        verbalDate: json["verbal_date"],
        receivedate: json["receivedate"],
        verbalAddress: json["verbal_address"],
        verbalComment: json["verbal_comment"],
        totalMin: json["total_min"],
        totalMax: json["total_max"],
        verbalImage: json["verbal_image"],
        latlongLog: json["latlong_log"],
        latlongLa: json["latlong_la"],
        verbalStatusId: json["verbal_status_id"],
        verbalPublished: json["verbal_published"],
        verbalUser: json["verbal_user"],
        verbalCreatedDate: json["verbal_created_date"],
      );

  Map<String?, dynamic> toJson() => {
        "verbal_id": verbalId,
        "verbal_code": verbalCode,
        "title_deedN": titleDeedN,
        "under_property_right": underPropertyRight,
        "referrenceN": referrenceN,
        "issued_date": issuedDate,
        "verbal_property_id": verbalPropertyId,
        "verbal_owner": verbalOwner,
        "verbal_contact": verbalContact,
        "verbal_date": verbalDate,
        "receivedate": receivedate,
        "verbal_address": verbalAddress,
        "verbal_comment": verbalComment,
        "total_min": totalMin,
        "total_max": totalMax,
        "verbal_image": verbalImage,
        "latlong_log": latlongLog,
        "latlong_la": latlongLa,
        "verbal_status_id": verbalStatusId,
        "verbal_published": verbalPublished,
        "verbal_user": verbalUser,
        "verbal_created_date": verbalCreatedDate,
      };
}
