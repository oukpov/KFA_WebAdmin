class BannerModel {
  int? id;
  String? bannerimage;
  String? url;

  BannerModel({this.id, this.bannerimage, this.url});

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerimage = json['bannerimage'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bannerimage'] = this.bannerimage;
    data['url'] = this.url;
    return data;
  }
}
