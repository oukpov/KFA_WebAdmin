class UsersModel {
  final String email;
  final String fullName;
  final List groups;
  final String image;
  final bool isOnline;
  final DateTime lastActive;
  // final String token;
  final String uid;
  const UsersModel({
    required this.fullName,
    required this.image,
    required this.lastActive,
    required this.uid,
    required this.email,
    this.isOnline = false,
    required this.groups,
    // required this.token
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        // token: json['token'],
        uid: json['uid'],
        fullName: json['fullName'] ?? "",
        image: json['image'] ?? "",
        email: json['email'],
        isOnline: json['isOnline'] ?? false,
        lastActive: json['lastActive'].toDate(),
        groups: List.from(json['groups'] ?? []),
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'fullName': fullName,
        'image': image,
        'email': email,
        'isOnline': isOnline,
        'lastActive': lastActive,
        'groups': groups,
        // 'token': token,
      };
}
