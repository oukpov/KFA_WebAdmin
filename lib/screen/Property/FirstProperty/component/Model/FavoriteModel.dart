class FavoriteModel {
  String userID;
  String idptys;
  int like;

  FavoriteModel(
    this.userID,
    this.idptys,
    this.like,
  );

  Map<String, dynamic> toMap() {
    return {
      'UserID': userID,
      'id_ptys': idptys,
      'like': like,
    };
  }
}
