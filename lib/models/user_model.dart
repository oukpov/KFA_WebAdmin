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
    // Safer parsing for adminId
    adminId = json['admin_id'] != null
        ? (json['admin_id'] is int
            ? json['admin_id']
            : int.tryParse(json['admin_id'].toString()))
        : null;

    // Safer parsing for userId
    userId = json['userId'] != null
        ? (json['userId'] is int
            ? json['userId']
            : int.tryParse(json['userId'].toString()))
        : null;

    approvedName = json['approved_name']?.toString();
    controlUser = json['control_user']?.toString();
    firstName = json['first_name']?.toString();
    lastName = json['last_name']?.toString();
    telNum = json['tel_num']?.toString();
    gender = json['gender']?.toString();
    knownFrom = json['known_from']?.toString();
    email = json['email']?.toString();
    approvalStatus = json['approval_status']?.toString();

    // Safer parsing for approvedBy
    approvedBy = json['approved_by'] != null
        ? (json['approved_by'] is int
            ? json['approved_by']
            : int.tryParse(json['approved_by'].toString()))
        : null;

    approvedAt = json['approved_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admin_id'] = adminId;
    data['userId'] = userId;
    data['approved_name'] = approvedName;
    data['control_user'] = controlUser;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['tel_num'] = telNum;
    data['gender'] = gender;
    data['known_from'] = knownFrom;
    data['email'] = email;
    data['approval_status'] = approvalStatus;
    data['approved_by'] = approvedBy;
    data['approved_at'] = approvedAt;
    return data;
  }
}
