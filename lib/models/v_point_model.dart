// class VpointModel {
//   int? iDControl;
//   String? telNum;
//   String? username;
//   String? idUserControl;
//   int? countAutoverbal;
//   String? create;
//   String? expiry;
//   String? theirPlans;
//   int? balance;
//   int? createdVerbals;

//   VpointModel(
//       {this.iDControl,
//       this.telNum,
//       this.username,
//       this.idUserControl,
//       this.countAutoverbal,
//       this.create,
//       this.expiry,
//       this.theirPlans,
//       this.balance,
//       this.createdVerbals});

//   VpointModel.fromJson(Map<String, dynamic> json) {
//     iDControl = json['ID_control'] != null
//         ? int.parse(json['ID_control'].toString())
//         : null;
//     telNum = json['tel_num'];
//     username = json['username'];
//     idUserControl = json['id_user_control'];
//     countAutoverbal = json['count_autoverbal'] != null
//         ? int.parse(json['count_autoverbal'].toString())
//         : null;
//     create = json['create'];
//     expiry = json['expiry'];
//     theirPlans = json['their_plans'];
//     balance =
//         json['balance'] != null ? int.parse(json['balance'].toString()) : null;
//     createdVerbals = json['created_verbals'] != null
//         ? int.parse(json['created_verbals'].toString())
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ID_control'] = this.iDControl;
//     data['tel_num'] = this.telNum;
//     data['username'] = this.username;
//     data['id_user_control'] = this.idUserControl;
//     data['count_autoverbal'] = this.countAutoverbal;
//     data['create'] = this.create;
//     data['expiry'] = this.expiry;
//     data['their_plans'] = this.theirPlans;
//     data['balance'] = this.balance;
//     data['created_verbals'] = this.createdVerbals;
//     return data;
//   }
// }
class VpointModel {
  int? iDControl;
  int? historyuserid;
  String? telNum;
  String? username;
  String? idUserControl;
  int? countAutoverbal;
  String? create;
  String? expiry;
  String? theirPlans;
  int? balance;
  String? updateAt;
  int? createdVerbals;

  VpointModel(
      {this.iDControl,
      this.historyuserid,
      this.telNum,
      this.username,
      this.idUserControl,
      this.countAutoverbal,
      this.create,
      this.expiry,
      this.theirPlans,
      this.balance,
      this.updateAt,
      this.createdVerbals});

  VpointModel.fromJson(Map<String, dynamic> json) {
    iDControl = json['ID_control'] != null
        ? int.parse(json['ID_control'].toString())
        : null;
    historyuserid = json['historyuserid'] != null
        ? int.parse(json['historyuserid'].toString())
        : null;
    telNum = json['tel_num'];
    username = json['username'];
    idUserControl = json['id_user_control'];
    countAutoverbal = json['count_autoverbal'] != null
        ? int.parse(json['count_autoverbal'].toString())
        : null;
    create = json['create'];
    expiry = json['expiry'];
    theirPlans = json['their_plans'];
    balance =
        json['balance'] != null ? int.parse(json['balance'].toString()) : null;
    updateAt = json['update_at'];
    createdVerbals = json['created_verbals'] != null
        ? int.parse(json['created_verbals'].toString())
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID_control'] = this.iDControl;
    data['historyuserid'] = this.historyuserid;
    data['tel_num'] = this.telNum;
    data['username'] = this.username;
    data['id_user_control'] = this.idUserControl;
    data['count_autoverbal'] = this.countAutoverbal;
    data['create'] = this.create;
    data['expiry'] = this.expiry;
    data['their_plans'] = this.theirPlans;
    data['balance'] = this.balance;
    data['update_at'] = this.updateAt;
    data['created_verbals'] = this.createdVerbals;
    return data;
  }
}
