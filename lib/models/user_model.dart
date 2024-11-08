import 'dart:convert';

User userModelFromJson(String str) => User.fromJson(json.decode(str));

String userModelToJson(User data) => json.encode(data.toJson());

class User {
  int? id; 
  String? token;
  String? username;
  String? email;
  
  User({
    this.id,
    required this.token,
    this.username,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    token: json["token"],
    username: json["username"],
    email: json["email"], 
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "token": token,
    "username": username,
    "email": email,
  };
}
