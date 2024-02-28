class Map_executive {
  int? propertycomparable_executive_id;
  int? propertycomparable_com_id;
  int? propertycomparable_status;

  String? propertycomparable_created_by;
  String? propertycomparable_modify_date;
  String? remember_token;

  Map_executive(
    this.propertycomparable_executive_id,
    this.propertycomparable_com_id,
    this.propertycomparable_status,
    this.propertycomparable_created_by,
    this.propertycomparable_modify_date,
    this.remember_token,
  );

  Map<String, dynamic> toMap() {
    return {
      'propertycomparable_executive_id': this.propertycomparable_executive_id,
      'propertycomparable_com_id': this.propertycomparable_com_id,
      'propertycomparable_status': this.propertycomparable_status,
      'propertycomparable_created_by': this.propertycomparable_created_by,
      'propertycomparable_modify_date': this.propertycomparable_modify_date,
      'remember_token': this.remember_token,
    };
  }
}
