class AboutUsModel {
  String? dearValueCustomer;
  String? companyOverview;
  String? visionMission;
  String? ourPeople;
  String? companyProfile;
  String? aboutCaption;
  AboutUsModel(
      {this.dearValueCustomer,
      this.companyOverview,
      this.visionMission,
      this.ourPeople,
      this.companyProfile,
      this.aboutCaption});

  AboutUsModel.fromJson(Map<String, dynamic> json) {
    dearValueCustomer = json['dear_value_customer'];
    companyOverview = json['company_overview'];
    visionMission = json['vision_mission'];
    ourPeople = json['our_people'];
    companyProfile = json['company_profile'];
    aboutCaption = json['about_caption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dear_value_customer'] = this.dearValueCustomer;
    data['company_overview'] = this.companyOverview;
    data['vision_mission'] = this.visionMission;
    data['our_people'] = this.ourPeople;
    data['company_profile'] = this.companyProfile;
    data['about_caption'] = this.aboutCaption;
    return data;
  }
}
