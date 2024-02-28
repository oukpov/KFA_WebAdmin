class building_execuactive {
  int? buildingExecutiveId;
  String? buildingSize;
  String? buildingPrice;
  String? buildingPricePer;
  String? buildingDes;
  int? building_published;
  String? remember_token;

  building_execuactive(
      this.buildingExecutiveId,
      this.buildingSize,
      this.buildingPrice,
      this.buildingPricePer,
      this.buildingDes,
      this.building_published,
      this.remember_token);

  Map<String, dynamic> toMap() {
    return {
      'building_executive_id': this.buildingExecutiveId,
      'building_size': this.buildingSize,
      'building_price': this.buildingPrice,
      'building_price_per': this.buildingPricePer,
      'building_des': this.buildingDes,
      'building_published': this.building_published,
      'remember_token': this.remember_token,
    };
  }
}
