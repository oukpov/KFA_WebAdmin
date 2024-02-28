import 'dart:convert';
import 'package:flutter/material.dart';
class SaleReponseModel {
  final String message;
  SaleReponseModel({
    required this.message,
  });
  factory SaleReponseModel.fromJson(Map<String, dynamic> json) {
    return SaleReponseModel(
      message: json["message"] ?? "",
    );
  }
}
class SaleModelRequest {
  int? ptySaleId;
  int? ptySaleImage;
  int? propertyId;
  int? ptySalePublic;
  double? lat;
  double? logs;
  int? forSaleUser;
  String? ptySaleKhan;
  String? address;
  String? land;
  String? sqm;
  String? bed;
  String? bath;
  String? price;

  SaleModelRequest(
      {this.ptySaleId,
      this.ptySaleImage,
      this.propertyId,
      this.ptySalePublic,
      this.lat,
      this.logs,
      this.forSaleUser,
      this.ptySaleKhan,
      this.address,
      this.land,
      this.sqm,
      this.bed,
      this.bath,
      this.price});

  SaleModelRequest.fromJson(Map<String, dynamic> json) {
    ptySaleId = json['pty_sale_id'];
    ptySaleImage = json['pty_sale_image'];
    propertyId = json['property_id'];
    ptySalePublic = json['pty_sale_public'];
    lat = json['lat'];
    logs = json['logs'];
    forSaleUser = json['for_sale_user'];
    ptySaleKhan = json['pty_sale_Khan'];
    address = json['address'];
    land = json['land'];
    sqm = json['sqm'];
    bed = json['bed'];
    bath = json['bath'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pty_sale_id'] = this.ptySaleId;
    data['pty_sale_image'] = this.ptySaleImage;
    data['property_id'] = this.propertyId;
    data['pty_sale_public'] = this.ptySalePublic;
    data['lat'] = this.lat;
    data['logs'] = this.logs;
    data['for_sale_user'] = this.forSaleUser;
    data['pty_sale_Khan'] = this.ptySaleKhan;
    data['address'] = this.address;
    data['land'] = this.land;
    data['sqm'] = this.sqm;
    data['bed'] = this.bed;
    data['bath'] = this.bath;
    data['price'] = this.price;
    return data;
  }
}