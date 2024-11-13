class SocialMediaModel {
  List<Data>? data;

  SocialMediaModel({this.data});

  SocialMediaModel.fromJson(Map<String, dynamic>? json) {
    if (json != null && json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? platform;
  String? url;
  String? iconName;
  String? active;
  String? displayOrder;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.platform,
    this.url,
    this.iconName,
    this.active,
    this.displayOrder,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['id']?.toString();
      platform = json['platform']?.toString();
      url = json['url']?.toString();
      iconName = json['icon_name']?.toString();
      active = json['active']?.toString();
      displayOrder = json['display_order']?.toString();
      createdAt = json['created_at']?.toString();
      updatedAt = json['updated_at']?.toString();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['platform'] = platform;
    data['url'] = url;
    data['icon_name'] = iconName;
    data['active'] = active;
    data['display_order'] = displayOrder;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
