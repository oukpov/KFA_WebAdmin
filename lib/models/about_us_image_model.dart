class AboutUsImageModel {
  String? id;
  String? image;
  String? url;
  String? createAt;

  AboutUsImageModel({this.id, this.image, this.url, this.createAt});

  AboutUsImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    url = json['url'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['url'] = this.url;
    data['create_at'] = this.createAt;
    return data;
  }
}
