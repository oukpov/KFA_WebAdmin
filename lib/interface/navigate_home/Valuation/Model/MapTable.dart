// ignore_for_file: unnecessary_this

class ModelTable {
  String? propertyTypeName;
  String? provincesName;
  String? districtName;
  String? communeName;
  int comparableId;
  String comparableSurveyDate;
  int comparablePropertyId;
  String? comparableLandLength;
  String? comparableLandWidth;
  String? comparableLandTotal;

  String? comparableSoldLength;
  String? comparableSoldWidth;
  String? comparableSoldTotal;
  String? comparableAddingPrice;
  String? comparableAddingTotal;
  String? comparableSoldPrice;
  String? comparablePhone;
  String? comparableSoldTotalPrice;
  String? comparableConditionId;
  String? comparableYear;
  String? comparableAddress;
  int comparableProvinceId;
  int comparableDistrictId;
  int comparableCommuneId;
  String? comparableRemark;
  String? comparableaddprice;
  String? comparableaddpricetotal;
  String? comparableboughtprice;
  String? comparableAmount;
  double latlongLog;
  double latlongLa;
  int comparablUser;
  int comparableCon;
  String? comparableboughtpricetotal;
  int compareBankId;
  int compareBankBranchId;
  String? comBankofficer;
  String? comBankofficerContact;
  String? comparableRoad;
  double distance;

  ModelTable(
    this.propertyTypeName,
    this.provincesName,
    this.districtName,
    this.communeName,
    this.comparableId,
    this.comparableSurveyDate,
    this.comparablePropertyId,
    this.comparableLandLength,
    this.comparableLandWidth,
    this.comparableLandTotal,
    this.comparableSoldLength,
    this.comparableSoldWidth,
    this.comparableSoldTotal,
    this.comparableAddingPrice,
    this.comparableAddingTotal,
    this.comparableSoldPrice,
    this.comparablePhone,
    this.comparableSoldTotalPrice,
    this.comparableConditionId,
    this.comparableYear,
    this.comparableAddress,
    this.comparableProvinceId,
    this.comparableDistrictId,
    this.comparableCommuneId,
    this.comparableRemark,
    this.comparableaddprice,
    this.comparableaddpricetotal,
    this.comparableboughtprice,
    this.comparableAmount,
    this.latlongLog,
    this.latlongLa,
    this.comparablUser,
    this.comparableCon,
    this.comparableboughtpricetotal,
    this.compareBankId,
    this.compareBankBranchId,
    this.comBankofficer,
    this.comBankofficerContact,
    this.comparableRoad,
    this.distance,
  );

  Map<String, dynamic?> toMap() {
    return {
      'property_type_name': this.propertyTypeName,
      'provinces_name': this.provincesName,
      'district_name': this.districtName,
      'commune_name': this.communeName,
      'comparable_id': this.comparableId,
      'comparable_survey_date': this.comparableSurveyDate,
      'comparable_property_id': this.comparablePropertyId,
      'comparable_land_length': this.comparableLandLength,
      'comparable_land_width': this.comparableLandWidth,
      'comparable_land_total': this.comparableLandTotal,
      'comparable_sold_length': this.comparableSoldLength,
      'comparable_sold_width': this.comparableSoldWidth,
      'comparable_sold_total': this.comparableSoldTotal,
      'comparable_adding_price': this.comparableAddingPrice,
      'comparable_adding_total': this.comparableAddingTotal,
      'comparable_sold_price': this.comparableSoldPrice,
      'comparable_phone': this.comparablePhone,
      'comparable_sold_total_price': this.comparableSoldTotalPrice,
      'comparable_condition_id': this.comparableConditionId,
      'comparable_year': this.comparableYear,
      'comparable_address': this.comparableAddress,
      'comparable_province_id': this.comparableProvinceId,
      'comparable_district_id': this.comparableDistrictId,
      'comparable_commune_id': this.comparableCommuneId,
      'comparable_remark': this.comparableRemark,
      'comparableaddprice': this.comparableaddprice,
      'comparableaddpricetotal': this.comparableaddpricetotal,
      'comparableboughtprice': this.comparableboughtprice,
      'comparableAmount': this.comparableAmount,
      'latlong_log': this.latlongLog,
      'latlong_la': this.latlongLa,
      'comparabl_user': this.comparablUser,
      'comparable_con': this.comparableCon,
      'comparableboughtpricetotal': this.comparableboughtpricetotal,
      'compare_bank_id': this.compareBankId,
      'compare_bank_branch_id': this.compareBankBranchId,
      'com_bankofficer': this.comBankofficer,
      'com_bankofficer_contact': this.comBankofficerContact,
      'comparable_road': this.comparableRoad,
      'distance': this.distance,
    };
  }
}
