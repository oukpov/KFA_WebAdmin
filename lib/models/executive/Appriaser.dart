class building_appraiser {
  int? appraiser_executiveid;
  int? appraiser_agent_id;
  int? appraiser_modify_by;
  String? appraiser_position;
  String? agenttype_name;
  String? appraiser_price;
  String? appraiser_remark;
  int? appraiser_published;
  String? appraiser_modify_date;

  building_appraiser(
      this.appraiser_executiveid,
      this.agenttype_name,
      this.appraiser_agent_id,
      this.appraiser_position,
      this.appraiser_price,
      this.appraiser_remark,
      this.appraiser_published,
      this.appraiser_modify_date,
      this.appraiser_modify_by);

  Map<String, dynamic> toMap() {
    return {
      'appraiser_executiveid': this.appraiser_executiveid,
      'agenttype_name': this.agenttype_name,
      'appraiser_agent_id': this.appraiser_agent_id,
      'appraiser_position': this.appraiser_position,
      'appraiser_price': this.appraiser_price,
      'appraiser_remark': this.appraiser_remark,
      'appraiser_published': this.appraiser_published,
      'appraiser_modify_date': this.appraiser_modify_date,
      'appraiser_modify_by': this.appraiser_modify_by,
    };
  }
}
