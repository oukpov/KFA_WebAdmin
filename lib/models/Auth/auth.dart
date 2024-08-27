class AuthenModel {
  String? message;
  bool? success;
  List<User>? user;

  AuthenModel({this.message, this.success, this.user});

  AuthenModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['success'] = success;
    if (user != null) {
      data['user'] = user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  int? userRoleId;
  int? agency;
  String? username;
  String? password;
  int? userStatus;

  User(
      {this.id,
      this.userRoleId,
      this.agency,
      this.username,
      this.password,
      this.userStatus});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userRoleId = json['user_role_id'];
    agency = json['agency'];
    username = json['username'];
    password = json['password'];
    userStatus = json['user_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_role_id'] = userRoleId;
    data['agency'] = agency;
    data['username'] = username;
    data['password'] = password;
    data['user_status'] = userStatus;
    return data;
  }
}
