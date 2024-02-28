// ignore_for_file: non_constant_identifier_names

class User {
  late String id;
  late String username;
  late String first_name;
  late String last_name;
  late String email;
  late String gender;
  late String from;
  late String tel;
  // Add whatever other properties you need to pull from the server here
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.first_name,
    required this.from,
    required this.gender,
    required this.last_name,
    required this.tel,
  });

  User.fromJson(data);
  // This function will help you convert the deata you receive from the server
  // into an instance of User
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "id": id,
      "first_name": first_name.trim(),
      "last_name": last_name.trim(),
      "username": username.trim(),
      "gender": gender.trim(),
      "tel_num": tel.trim(),
      "known_from": from.trim(),
      "email": email.trim(),
    };
    return map;
  }
}

class List_User {
  List<Users>? users;

  List_User({this.users});

  List_User.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? gender;
  String? telNum;
  String? knownFrom;
  String? email;
  Null? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  Users(
      {this.id,
      this.firstName,
      this.lastName,
      this.username,
      this.gender,
      this.telNum,
      this.knownFrom,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    gender = json['gender'];
    telNum = json['tel_num'];
    knownFrom = json['known_from'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['username'] = this.username;
    data['gender'] = this.gender;
    data['tel_num'] = this.telNum;
    data['known_from'] = this.knownFrom;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
