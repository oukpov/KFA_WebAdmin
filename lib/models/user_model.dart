class UserModel {
  int? adminId;
  int? userId;
  String? approvedName;
  String? controlUser;
  String? firstName;
  String? lastName;
  String? telNum;
  String? gender;
  String? knownFrom;
  String? email;
  String? approvalStatus;
  int? approvedBy;
  String? approvedAt;

  UserModel(
      {this.adminId,
      this.userId,
      this.approvedName,
      this.controlUser,
      this.firstName,
      this.lastName,
      this.telNum,
      this.gender,
      this.knownFrom,
      this.email,
      this.approvalStatus,
      this.approvedBy,
      this.approvedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    adminId = json['admin_id'];
    userId = json['userId'];
    approvedName = json['approved_name'];
    controlUser = json['control_user'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    telNum = json['tel_num'];
    gender = json['gender'];
    knownFrom = json['known_from'];
    email = json['email'];
    approvalStatus = json['approval_status'];
    approvedBy = json['approved_by'];
    approvedAt = json['approved_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admin_id'] = this.adminId;
    data['userId'] = this.userId;
    data['approved_name'] = this.approvedName;
    data['control_user'] = this.controlUser;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['tel_num'] = this.telNum;
    data['gender'] = this.gender;
    data['known_from'] = this.knownFrom;
    data['email'] = this.email;
    data['approval_status'] = this.approvalStatus;
    data['approved_by'] = this.approvedBy;
    data['approved_at'] = this.approvedAt;
    return data;
  }
}
