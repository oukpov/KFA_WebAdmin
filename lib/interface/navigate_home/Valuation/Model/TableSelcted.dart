class Selected {
  int? comparableId;
  bool? select;

  Selected(
    this.comparableId,
    this.select,
  );

  Map<String, dynamic> toMap() {
    return {
      'comparable_id': this.comparableId,
      'select': this.select,
    };
  }
}
