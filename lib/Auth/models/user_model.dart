import 'package:flutter/material.dart';

class UserModel {
  String id;
  String email;
  String city;
  String country;
  String fName;
  String lName;
  String imageUrl;
  UserModel({
    @required this.id,
    @required this.email,
    @required this.city,
    @required this.country,
    @required this.fName,
    @required this.lName,
    @required this.imageUrl,
  });

  UserModel.fromMap(Map map) {
    this.id = map['id'];
    this.email = map['email'];
    this.city = map['city'];
    this.country = map['country'];
    this.fName = map['fName'];
    this.lName = map['lName'];
    this.imageUrl = map['imageUrl'];
  }
  toMap() {
    return imageUrl == null
        ? {
            'city': this.city,
            'country': this.country,
            'fName': this.fName,
            'lName': this.lName,
          }
        : {
            'city': this.city,
            'country': this.country,
            'fName': this.fName,
            'lName': this.lName,
            'imageUrl': this.imageUrl,
          };
  }
}
