import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
    int id;
    String username;
    String email;

    Profile({
        required this.id,
        required this.username,
        required this.email,
    });

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        username: json["username"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
    };
}
