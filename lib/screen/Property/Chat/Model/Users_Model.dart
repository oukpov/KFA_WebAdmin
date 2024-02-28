class UserModel {
  final String uid;
  final String name;
  final String email;
  final String image;
  final DateTime lastActive;
  final bool isOnline;
  final List groups;

  const UserModel(
      {required this.name,
      required this.image,
      required this.lastActive,
      required this.uid,
      required this.email,
      this.isOnline = false,
      required this.groups});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
        name: json['fullName'] ?? "",
        image: json['image'] ?? "",
        email: json['email'],
        isOnline: json['isOnline'] ?? false,
        lastActive: json['lastActive'].toDate(),
        groups: List.from(json['groups'] ?? []),
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'fullName': name,
        'image': image,
        'email': email,
        'isOnline': isOnline,
        'lastActive': lastActive,
        'groups': groups,
      };
}
