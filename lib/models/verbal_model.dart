class Verbal_model {
  int? verbalId;
  String? titleNumber;
  String? approvel;
  String? agentName;
  int? agentId;
  int? protectID;
  int? verbalPropertyId;
  String? borey;
  int? road;
  int? verbalBankId;
  int? verbalBankBranchId;
  String? verbalBankContact;
  String? verbalOwner;
  String? verbalContact;
  String? verbalDate;
  String? verbalBankOfficer;
  String? verbalAddress;
  int? verbalProvinceId;
  String? roadName;
  int? verbalApproveId;
  int? verbalApprovesId;
  String? verbalComment;
  double? latlongLog;
  double? latlongLa;
  String? verbalCom;
  String? verbalCon;
  String? verbalOption;
  int? verbalStatusId;
  int? verbalUser;
  int? verbalComp;
  String? verifyAgent;
  int? verbalCreatedBy;
  String? verbalCreatedDate;
  int? verbalModifyBy;
  String? verbalKhan;
  int? propertyTypeId;
  String? propertyTypeName;
  bool? propertyTypePublished;
  String? propertyTypeColor;
  String? propertyColos;
  String? bankAcronym;
  String? bankBranchName;
  String? bankName;
  String? bankofficer;
  String? bankcontact;
  int? bankProvinceId;
  int? bankDistrictId;
  int? bankCommuneId;
  String? bankVillage;
  int? approveId;
  String? approveName;
  int? agenttypeId;
  String? agenttypeName;
  String? agentTypePhone;
  String? agentTypeEmail;
  int? controlUser;
  String? firstName;
  String? lastName;
  String? username;
  String? gender;
  String? telNum;
  String? knownFrom;

  Verbal_model(
      {this.verbalId,
      this.titleNumber,
      this.approvel,
      this.agentName,
      this.agentId,
      this.protectID,
      this.verbalPropertyId,
      this.borey,
      this.road,
      this.verbalBankId,
      this.verbalBankBranchId,
      this.verbalBankContact,
      this.verbalOwner,
      this.verbalContact,
      this.verbalDate,
      this.verbalBankOfficer,
      this.verbalAddress,
      this.verbalProvinceId,
      this.roadName,
      this.verbalApproveId,
      this.verbalApprovesId,
      this.verbalComment,
      this.latlongLog,
      this.latlongLa,
      this.verbalCom,
      this.verbalCon,
      this.verbalOption,
      this.verbalStatusId,
      this.verbalUser,
      this.verbalComp,
      this.verifyAgent,
      this.verbalCreatedBy,
      this.verbalCreatedDate,
      this.verbalModifyBy,
      this.verbalKhan,
      this.propertyTypeId,
      this.propertyTypeName,
      this.propertyTypePublished,
      this.propertyTypeColor,
      this.propertyColos,
      this.bankAcronym,
      this.bankBranchName,
      this.bankName,
      this.bankofficer,
      this.bankcontact,
      this.bankProvinceId,
      this.bankDistrictId,
      this.bankCommuneId,
      this.bankVillage,
      this.approveId,
      this.approveName,
      this.agenttypeId,
      this.agenttypeName,
      this.agentTypePhone,
      this.agentTypeEmail,
      this.controlUser,
      this.firstName,
      this.lastName,
      this.username,
      this.gender,
      this.telNum,
      this.knownFrom});

  Verbal_model.fromJson(Map<String, dynamic> json) {
    verbalId = json['verbal_id'] != null
        ? int.tryParse(json['verbal_id'].toString())
        : null;
    titleNumber = json['title_number']?.toString();
    approvel = json['approvel']?.toString();
    agentName = json['agent_name']?.toString();
    agentId = json['agent_id'] != null
        ? int.tryParse(json['agent_id'].toString())
        : null;
    protectID = json['protectID'] != null
        ? int.tryParse(json['protectID'].toString())
        : null;
    verbalPropertyId = json['verbal_property_id'] != null
        ? int.tryParse(json['verbal_property_id'].toString())
        : null;
    borey = json['borey']?.toString();
    road = json['road'] != null ? int.tryParse(json['road'].toString()) : null;
    verbalBankId = json['verbal_bank_id'] != null
        ? int.tryParse(json['verbal_bank_id'].toString())
        : null;
    verbalBankBranchId = json['verbal_bank_branch_id'] != null
        ? int.tryParse(json['verbal_bank_branch_id'].toString())
        : null;
    verbalBankContact = json['verbal_bank_contact']?.toString();
    verbalOwner = json['verbal_owner']?.toString();
    verbalContact = json['verbal_contact']?.toString();
    verbalDate = json['verbal_date']?.toString();
    verbalBankOfficer = json['verbal_bank_officer']?.toString();
    verbalAddress = json['verbal_address']?.toString();
    verbalProvinceId = json['verbal_province_id'] != null
        ? int.tryParse(json['verbal_province_id'].toString())
        : null;
    roadName = json['road_name']?.toString();
    verbalApproveId = json['verbal_approve_id'] != null
        ? int.tryParse(json['verbal_approve_id'].toString())
        : null;
    verbalApprovesId = json['verbal_approves_id'] != null
        ? int.tryParse(json['verbal_approves_id'].toString())
        : null;
    verbalComment = json['verbal_comment']?.toString();
    latlongLog = json['latlong_log'] != null
        ? double.tryParse(json['latlong_log'].toString())
        : null;
    latlongLa = json['latlong_la'] != null
        ? double.tryParse(json['latlong_la'].toString())
        : null;
    verbalCom = json['verbal_com']?.toString();
    verbalCon = json['verbal_con']?.toString();
    verbalOption = json['verbal_option']?.toString();
    verbalStatusId = json['verbal_status_id'] != null
        ? int.tryParse(json['verbal_status_id'].toString())
        : null;
    verbalUser = json['verbal_user'] != null
        ? int.tryParse(json['verbal_user'].toString())
        : null;
    verbalComp = json['verbal_comp'] != null
        ? int.tryParse(json['verbal_comp'].toString())
        : null;
    verifyAgent = json['VerifyAgent']?.toString();
    verbalCreatedBy = json['verbal_created_by'] != null
        ? int.tryParse(json['verbal_created_by'].toString())
        : null;
    verbalCreatedDate = json['verbal_created_date']?.toString();
    verbalModifyBy = json['verbal_modify_by'] != null
        ? int.tryParse(json['verbal_modify_by'].toString())
        : null;
    verbalKhan = json['verbal_khan']?.toString();
    propertyTypeId = json['property_type_id'] != null
        ? int.tryParse(json['property_type_id'].toString())
        : null;
    propertyTypeName = json['property_type_name']?.toString();
    propertyTypePublished = json['property_type_published'] != null
        ? json['property_type_published'] as bool
        : null;
    propertyTypeColor = json['property_type_color']?.toString();
    propertyColos = json['property_colos']?.toString();
    bankAcronym = json['bank_acronym']?.toString();
    bankBranchName = json['bank_branch_name']?.toString();
    bankName = json['bank_name']?.toString();
    bankofficer = json['bankofficer']?.toString();
    bankcontact = json['bankcontact']?.toString();
    bankProvinceId = json['bank_province_id'] != null
        ? int.tryParse(json['bank_province_id'].toString())
        : null;
    bankDistrictId = json['bank_district_id'] != null
        ? int.tryParse(json['bank_district_id'].toString())
        : null;
    bankCommuneId = json['bank_commune_id'] != null
        ? int.tryParse(json['bank_commune_id'].toString())
        : null;
    bankVillage = json['bank_village']?.toString();
    approveId = json['approve_id'] != null
        ? int.tryParse(json['approve_id'].toString())
        : null;
    approveName = json['approve_name']?.toString();
    agenttypeId = json['agenttype_id'] != null
        ? int.tryParse(json['agenttype_id'].toString())
        : null;
    agenttypeName = json['agenttype_name']?.toString();
    agentTypePhone = json['agent_type_phone']?.toString();
    agentTypeEmail = json['agent_type_email']?.toString();
    controlUser = json['control_user'] != null
        ? int.tryParse(json['control_user'].toString())
        : null;
    firstName = json['first_name']?.toString();
    lastName = json['last_name']?.toString();
    username = json['username']?.toString();
    gender = json['gender']?.toString();
    telNum = json['tel_num']?.toString();
    knownFrom = json['known_from']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verbal_id'] = this.verbalId;
    data['title_number'] = this.titleNumber;
    data['approvel'] = this.approvel;
    data['agent_name'] = this.agentName;
    data['agent_id'] = this.agentId;
    data['protectID'] = this.protectID;
    data['verbal_property_id'] = this.verbalPropertyId;
    data['borey'] = this.borey;
    data['road'] = this.road;
    data['verbal_bank_id'] = this.verbalBankId;
    data['verbal_bank_branch_id'] = this.verbalBankBranchId;
    data['verbal_bank_contact'] = this.verbalBankContact;
    data['verbal_owner'] = this.verbalOwner;
    data['verbal_contact'] = this.verbalContact;
    data['verbal_date'] = this.verbalDate;
    data['verbal_bank_officer'] = this.verbalBankOfficer;
    data['verbal_address'] = this.verbalAddress;
    data['verbal_province_id'] = this.verbalProvinceId;
    data['road_name'] = this.roadName;
    data['verbal_approve_id'] = this.verbalApproveId;
    data['verbal_approves_id'] = this.verbalApprovesId;
    data['verbal_comment'] = this.verbalComment;
    data['latlong_log'] = this.latlongLog;
    data['latlong_la'] = this.latlongLa;
    data['verbal_com'] = this.verbalCom;
    data['verbal_con'] = this.verbalCon;
    data['verbal_option'] = this.verbalOption;
    data['verbal_status_id'] = this.verbalStatusId;
    data['verbal_user'] = this.verbalUser;
    data['verbal_comp'] = this.verbalComp;
    data['VerifyAgent'] = this.verifyAgent;
    data['verbal_created_by'] = this.verbalCreatedBy;
    data['verbal_created_date'] = this.verbalCreatedDate;
    data['verbal_modify_by'] = this.verbalModifyBy;
    data['verbal_khan'] = this.verbalKhan;
    data['property_type_id'] = this.propertyTypeId;
    data['property_type_name'] = this.propertyTypeName;
    data['property_type_published'] = this.propertyTypePublished;
    data['property_type_color'] = this.propertyTypeColor;
    data['property_colos'] = this.propertyColos;
    data['bank_acronym'] = this.bankAcronym;
    data['bank_branch_name'] = this.bankBranchName;
    data['bank_name'] = this.bankName;
    data['bankofficer'] = this.bankofficer;
    data['bankcontact'] = this.bankcontact;
    data['bank_province_id'] = this.bankProvinceId;
    data['bank_district_id'] = this.bankDistrictId;
    data['bank_commune_id'] = this.bankCommuneId;
    data['bank_village'] = this.bankVillage;
    data['approve_id'] = this.approveId;
    data['approve_name'] = this.approveName;
    data['agenttype_id'] = this.agenttypeId;
    data['agenttype_name'] = this.agenttypeName;
    data['agent_type_phone'] = this.agentTypePhone;
    data['agent_type_email'] = this.agentTypeEmail;
    data['control_user'] = this.controlUser;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['username'] = this.username;
    data['gender'] = this.gender;
    data['tel_num'] = this.telNum;
    data['known_from'] = this.knownFrom;
    return data;
  }
}
