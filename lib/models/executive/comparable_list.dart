class Map_Comparable {
  String? property_type_name;
  String? comparable_land_total;
  String? comparable_sold_total;
  String? comparable_adding_price;
  String? comparableaddprice;
  String? comparableboughtprice;
  String? comparable_sold_price;
  String? provinces_name;
  String? district_name;
  String? commune_name;
  String? comparable_survey_date;
  int? comparable_id;
  Map_Comparable(
    this.comparable_id,
    this.property_type_name,
    this.comparable_land_total,
    this.comparable_sold_total,
    this.comparable_adding_price,
    this.comparableaddprice,
    this.comparableboughtprice,
    this.comparable_sold_price,
    this.provinces_name,
    this.district_name,
    this.commune_name,
    this.comparable_survey_date,
  );

  Map<String, dynamic> toMap() {
    return {
      'comparable_id': this.comparable_id,
      'property_type_name': this.property_type_name,
      'comparable_land_total': this.comparable_land_total,
      'comparable_sold_total': this.comparable_sold_total,
      'comparable_adding_price': this.comparable_adding_price,
      'comparableaddprice': this.comparableaddprice,
      'comparableboughtprice': this.comparableboughtprice,
      'comparable_sold_price': this.comparable_sold_price,
      'provinces_name': this.provinces_name,
      'district_name': this.district_name,
      'commune_name': this.commune_name,
      'comparable_survey_date': this.comparable_survey_date,
    };
  }
}
