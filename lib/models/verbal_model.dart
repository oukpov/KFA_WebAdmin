class Verbal_model {
  int? verbalId;
  Null? titleNumber;
  Null? approvel;
  Null? agentName;
  Null? agentId;
  int? protectID;
  Null? verbalPropertyId;
  Null? borey;
  int? road;
  Null? verbalBankId;
  Null? verbalBankBranchId;
  Null? verbalBankContact;
  Null? verbalOwner;
  Null? verbalContact;
  Null? verbalDate;
  Null? verbalBankOfficer;
  Null? verbalAddress;
  Null? verbalProvinceId;
  Null? roadName;
  Null? verbalApproveId;
  Null? verbalApprovesId;
  Null? verbalComment;
  double? latlongLog;
  double? latlongLa;
  Null? verbalCom;
  Null? verbalCon;
  Null? verbalOption;
  int? verbalStatusId;
  int? verbalUser;
  int? verbalComp;
  Null? verifyAgent;
  Null? verbalCreatedBy;
  String? verbalCreatedDate;
  Null? verbalModifyBy;
  Null? verbalKhan;
  Null? propertyTypeId;
  Null? propertyTypeName;
  Null? propertyTypePublished;
  Null? propertyTypeColor;
  Null? propertyColos;
  Null? bankAcronym;
  Null? bankBranchName;
  Null? bankName;
  Null? bankofficer;
  Null? bankcontact;
  Null? bankProvinceId;
  Null? bankDistrictId;
  Null? bankCommuneId;
  Null? bankVillage;
  Null? approveId;
  Null? approveName;
  Null? agenttypeId;
  Null? agenttypeName;
  Null? agentTypePhone;
  Null? agentTypeEmail;
  Null? controlUser;
  Null? firstName;
  Null? lastName;
  Null? username;
  Null? gender;
  Null? telNum;
  Null? knownFrom;

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
    verbalId = json['verbal_id'];
    titleNumber = json['title_number'];
    approvel = json['approvel'];
    agentName = json['agent_name'];
    agentId = json['agent_id'];
    protectID = json['protectID'];
    verbalPropertyId = json['verbal_property_id'];
    borey = json['borey'];
    road = json['road'];
    verbalBankId = json['verbal_bank_id'];
    verbalBankBranchId = json['verbal_bank_branch_id'];
    verbalBankContact = json['verbal_bank_contact'];
    verbalOwner = json['verbal_owner'];
    verbalContact = json['verbal_contact'];
    verbalDate = json['verbal_date'];
    verbalBankOfficer = json['verbal_bank_officer'];
    verbalAddress = json['verbal_address'];
    verbalProvinceId = json['verbal_province_id'];
    roadName = json['road_name'];
    verbalApproveId = json['verbal_approve_id'];
    verbalApprovesId = json['verbal_approves_id'];
    verbalComment = json['verbal_comment'];
    latlongLog = json['latlong_log'];
    latlongLa = json['latlong_la'];
    verbalCom = json['verbal_com'];
    verbalCon = json['verbal_con'];
    verbalOption = json['verbal_option'];
    verbalStatusId = json['verbal_status_id'];
    verbalUser = json['verbal_user'];
    verbalComp = json['verbal_comp'];
    verifyAgent = json['VerifyAgent'];
    verbalCreatedBy = json['verbal_created_by'];
    verbalCreatedDate = json['verbal_created_date'];
    verbalModifyBy = json['verbal_modify_by'];
    verbalKhan = json['verbal_khan'];
    propertyTypeId = json['property_type_id'];
    propertyTypeName = json['property_type_name'];
    propertyTypePublished = json['property_type_published'];
    propertyTypeColor = json['property_type_color'];
    propertyColos = json['property_colos'];
    bankAcronym = json['bank_acronym'];
    bankBranchName = json['bank_branch_name'];
    bankName = json['bank_name'];
    bankofficer = json['bankofficer'];
    bankcontact = json['bankcontact'];
    bankProvinceId = json['bank_province_id'];
    bankDistrictId = json['bank_district_id'];
    bankCommuneId = json['bank_commune_id'];
    bankVillage = json['bank_village'];
    approveId = json['approve_id'];
    approveName = json['approve_name'];
    agenttypeId = json['agenttype_id'];
    agenttypeName = json['agenttype_name'];
    agentTypePhone = json['agent_type_phone'];
    agentTypeEmail = json['agent_type_email'];
    controlUser = json['control_user'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    gender = json['gender'];
    telNum = json['tel_num'];
    knownFrom = json['known_from'];
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
