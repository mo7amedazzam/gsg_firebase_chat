import 'dart:convert';

import 'package:flutter/cupertino.dart';

class RegisterRequest {
  String id;
  String email;
  String password;
  String city;
  String country;
  String fName;
  String lName;
  String imageUrl;
  RegisterRequest({
    @required this.id,
    @required this.email,
    @required this.password,
    @required this.city,
    @required this.country,
    @required this.fName,
    @required this.lName,
    @required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'city': city,
      'country': country,
      'fName': fName,
      'lName': lName,
      'imageUrl': imageUrl
    };
  }
}
