import 'package:cloud_firestore/cloud_firestore.dart';

class UserSearchModel {
  final String uid;
  final String name;
  final String email;
  final String image;
  final DateTime? lastActive; // Make lastActive nullable
  final bool isOnline;
  final List groups;

  const UserSearchModel({
    required this.name,
    required this.image,
    required this.uid,
    required this.email,
    this.isOnline = false,
    required this.groups,
    this.lastActive, // Nullable lastActive
  });

  factory UserSearchModel.fromJson(Map<String, dynamic> json) =>
      UserSearchModel(
        uid: json['uid'],
        name: json['fullName'] ?? "",
        image: json['image'] ?? "",
        email: json['email'],
        isOnline: json['isOnline'] ?? false,
        lastActive: json['lastActive'] !=
                null // Check if lastActive is not null
            ? (json['lastActive'] as Timestamp).toDate() // Convert to DateTime
            : null, // If null, assign null
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
