class ContactUsModel {
  List<Data>? data;

  ContactUsModel({this.data});

  ContactUsModel.fromJson(Map<String, dynamic>? json) {
    if (json != null && json['data'] != null) {
      data = <Data>[];
      try {
        json['data'].forEach((v) {
          data!.add(Data.fromJson(v));
        });
      } catch (e) {
        print('Error parsing contact us data: $e');
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      try {
        data['data'] = this.data!.map((v) => v.toJson()).toList();
      } catch (e) {
        print('Error converting contact us data to JSON: $e');
      }
    }
    return data;
  }
}

class Data {
  String? id;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? state;
  String? postalCode;
  String? country;
  String? latitude;
  String? longitude;
  String? mapUrl;
  String? hotlinePrimary;
  String? hotlineSecondary;
  String? hotlineThird;
  String? email;
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.latitude,
    this.longitude,
    this.mapUrl,
    this.hotlinePrimary,
    this.hotlineSecondary,
    this.hotlineThird,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      try {
        id = json['id']?.toString();
        addressLine1 = json['address_line1']?.toString();
        addressLine2 = json['address_line2']?.toString();
        city = json['city']?.toString();
        state = json['state']?.toString();
        postalCode = json['postal_code']?.toString();
        country = json['country']?.toString();
        latitude = json['latitude']?.toString();
        longitude = json['longitude']?.toString();
        mapUrl = json['map_url']?.toString();
        hotlinePrimary = json['hotline_primary']?.toString();
        hotlineSecondary = json['hotline_secondary']?.toString();
        hotlineThird = json['hotline_third']?.toString();
        email = json['email']?.toString();
        createdAt = json['created_at']?.toString();
        updatedAt = json['updated_at']?.toString();
      } catch (e) {
        print('Error parsing contact data fields: $e');
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    try {
      data['id'] = id;
      data['address_line1'] = addressLine1;
      data['address_line2'] = addressLine2;
      data['city'] = city;
      data['state'] = state;
      data['postal_code'] = postalCode;
      data['country'] = country;
      data['latitude'] = latitude;
      data['longitude'] = longitude;
      data['map_url'] = mapUrl;
      data['hotline_primary'] = hotlinePrimary;
      data['hotline_secondary'] = hotlineSecondary;
      data['hotline_third'] = hotlineThird;
      data['email'] = email;
      data['created_at'] = createdAt;
      data['updated_at'] = updatedAt;
    } catch (e) {
      print('Error converting contact data to JSON: $e');
    }
    return data;
  }
}
