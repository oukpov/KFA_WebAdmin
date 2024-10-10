class VpointModel {
  int? iDControl;
  String? telNum;
  String? username;
  String? idUserControl;
  int? countAutoverbal;
  String? create;
  String? expiry;
  String? theirPlans;
  int? balance;
  int? createdVerbals;

  VpointModel(
      {this.iDControl,
      this.telNum,
      this.username,
      this.idUserControl,
      this.countAutoverbal,
      this.create,
      this.expiry,
      this.theirPlans,
      this.balance,
      this.createdVerbals});

  VpointModel.fromJson(Map<String, dynamic> json) {
    iDControl = json['ID_control'];
    telNum = json['tel_num'];
    username = json['username'];
    idUserControl = json['id_user_control'];
    countAutoverbal = json['count_autoverbal'];
    create = json['create'];
    expiry = json['expiry'];
    theirPlans = json['their_plans'];
    balance = json['balance'];
    createdVerbals = json['created_verbals'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID_control'] = this.iDControl;
    data['tel_num'] = this.telNum;
    data['username'] = this.username;
    data['id_user_control'] = this.idUserControl;
    data['count_autoverbal'] = this.countAutoverbal;
    data['create'] = this.create;
    data['expiry'] = this.expiry;
    data['their_plans'] = this.theirPlans;
    data['balance'] = this.balance;
    data['created_verbals'] = this.createdVerbals;
    return data;
  }
}
