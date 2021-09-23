// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  Profile({
    this.success,
    this.data,
  });

  bool success;
  List<Data> data;

  factory Profile.fromJson(Map<dynamic, dynamic> json) => Profile(
    success: json["success"],
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
  );

  Map<dynamic, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Data {
  Data({
    this.id,
    this.username,
    this.name,
    this.surname,
    this.image,
    this.v,
  });

  String id;
  String username;
  String name;
  String surname;
  String image;
  int v;

  factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
    id: json["_id"],
    username: json["username"],
    name: json["name"],
    surname: json["surname"],
    image: json["image"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "name": name,
    "surname": surname,
    "image": image,
    "__v": v,
  };
}
