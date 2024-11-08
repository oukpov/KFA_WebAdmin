class PromotionModel {
  String? id;
  String? title;
  String? descrition;
  String? url;
  String? image;
  String? link;
  String? createDate;
  String? type;

  PromotionModel(
      {this.id,
      this.title,
      this.descrition,
      this.url,
      this.image,
      this.link,
      this.createDate,
      this.type});

  PromotionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    title = json['title'] ?? '';
    descrition = json['descrition'] ?? '';
    url = json['url'] ?? '';
    image = json['image'] ?? '';
    link = json['link'] ?? '';
    createDate = json['createDate'] ?? '';
    type = json['type'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id ?? '';
    data['title'] = this.title ?? '';
    data['descrition'] = this.descrition ?? '';
    data['url'] = this.url ?? '';
    data['image'] = this.image ?? '';
    data['link'] = this.link ?? '';
    data['createDate'] = this.createDate ?? '';
    data['type'] = this.type ?? '';
    return data;
  }
}
