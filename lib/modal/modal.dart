// To parse this JSON data, do
//
//     final users = usersFromMap(jsonString);

import 'dart:convert';

List<Users> usersFromMap(String str) => List<Users>.from(json.decode(str).map((x) => Users.fromMap(x)));

String usersToMap(List<Users> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Users {
  Users({
    this.entityName,
    this.instanceName,
    this.id,
    this.lastName,
    this.loginLowerCase,
    this.language,
    this.availability,
    this.login,
    this.password,
    this.changePasswordAtNextLogon,
    this.active,
    this.fullName,
    this.version,
    this.firstName,
    this.name,
    this.shortName,
  });

  String entityName;
  String instanceName;
  String id;
  String lastName;
  String loginLowerCase;
  String language;
  bool availability;
  String login;
  String password;
  bool changePasswordAtNextLogon;
  bool active;
  String fullName;
  int version;
  String firstName;
  String name;
  String shortName;

  factory Users.fromMap(Map<String, dynamic> json) => Users(
    entityName: json["_entityName"],
    instanceName: json["_instanceName"],
    id: json["id"],
    lastName: json["lastName"],
    loginLowerCase: json["loginLowerCase"],
    language: json["language"],
    availability: json["availability"],
    login: json["login"],
    password: json["password"],
    changePasswordAtNextLogon: json["changePasswordAtNextLogon"],
    active: json["active"],
    fullName: json["fullName"],
    version: json["version"],
    firstName: json["firstName"],
    name: json["name"],
    shortName: json["shortName"],
  );

  Map<String, dynamic> toMap() => {
    "_entityName": entityName,
    "_instanceName": instanceName,
    "id": id,
    "lastName": lastName,
    "loginLowerCase": loginLowerCase,
    "language": language,
    "availability": availability,
    "login": login,
    "password": password,
    "changePasswordAtNextLogon": changePasswordAtNextLogon,
    "active": active,
    "fullName": fullName,
    "version": version,
    "firstName": firstName,
    "name": name,
    "shortName": shortName,
  };
}
