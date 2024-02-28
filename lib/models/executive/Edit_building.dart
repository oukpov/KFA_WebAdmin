class Building_only_ReponseModel {
  final String message;
  Building_only_ReponseModel({
    required this.message,
  });
  factory Building_only_ReponseModel.fromJson(Map<String, dynamic> json) {
    return Building_only_ReponseModel(
      message: json["message"] ?? "",
    );
  }
}

class BuildingRequestModel_2023 {
  late List building;

  //VerbalTypeRequestModel data;
  // List<VerbalTypeRequestModel> autoVerbal;
  BuildingRequestModel_2023({
    required this.building,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "building": building,
    };
    return map;
  }
}
