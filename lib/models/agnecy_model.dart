class AgencyModel {
  int? agenttypeId;
  String? agenttypeName;
  Null? agentTypePhone;
  Null? agentTypeEmail;
  String? agenttypeCreatedDate;

  AgencyModel(
      {this.agenttypeId,
      this.agenttypeName,
      this.agentTypePhone,
      this.agentTypeEmail,
      this.agenttypeCreatedDate});

  AgencyModel.fromJson(Map<String, dynamic> json) {
    agenttypeId = json['agenttype_id'];
    agenttypeName = json['agenttype_name'];
    agentTypePhone = json['agent_type_phone'];
    agentTypeEmail = json['agent_type_email'];
    agenttypeCreatedDate = json['agenttype_created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['agenttype_id'] = this.agenttypeId;
    data['agenttype_name'] = this.agenttypeName;
    data['agent_type_phone'] = this.agentTypePhone;
    data['agent_type_email'] = this.agentTypeEmail;
    data['agenttype_created_date'] = this.agenttypeCreatedDate;
    return data;
  }
}
