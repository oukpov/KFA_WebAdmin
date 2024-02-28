class EmailSaveModel {
  String idPtys;
  String price;
  String sqm;
  String bed;
  String bath;
  String type;
  String land;
  String address;
  String title;
  String description;
  String hometype;
  String propertyTypeId;
  String url;
  String urgent;
  String lat;
  String log;
  String nameCummune;
  String privateArea;
  String livingroom;
  String parking;
  String sizeW;
  String sizeL;
  String floor;
  String landL;
  String landW;
  String sizeHouse;
  String totalArea;
  String priceSqm;
  String aircon;
  bool click;

  EmailSaveModel(
      this.idPtys,
      this.price,
      this.sqm,
      this.bed,
      this.bath,
      this.type,
      this.land,
      this.address,
      this.title,
      this.description,
      this.hometype,
      this.propertyTypeId,
      this.url,
      this.urgent,
      this.lat,
      this.log,
      this.nameCummune,
      this.privateArea,
      this.livingroom,
      this.parking,
      this.sizeW,
      this.sizeL,
      this.floor,
      this.landL,
      this.landW,
      this.sizeHouse,
      this.totalArea,
      this.priceSqm,
      this.aircon,
      this.click);

  Map<String, dynamic> toMap() {
    return {
      "id_ptys": idPtys,
      "price": price,
      "sqm": sqm,
      "bed": bed,
      "bath": bath,
      "type": type,
      "land": land,
      "address": address,
      "Title": title,
      "description": description,
      "hometype": hometype,
      "property_type_id": propertyTypeId,
      "url": url,
      "urgent": urgent,
      "lat": lat,
      "log": log,
      "Name_cummune": nameCummune,
      "Private_Area": privateArea,
      "Livingroom": livingroom,
      "Parking": parking,
      "size_w": sizeW,
      "Size_l": sizeL,
      "floor": floor,
      "land_l": landL,
      "land_w": landW,
      "size_house": sizeHouse,
      "total_area": totalArea,
      "price_sqm": priceSqm,
      "aircon": aircon,
      "click": click,
    };
  }
}
