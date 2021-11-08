import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoginUser {
  String email;
  String password;

  LoginUser({
    @required this.email,
    @required this.password,
  });
  factory LoginUser.map(Map map) {
    return LoginUser(email: map['emailAddress'], password: map['password']);
  }
  Map<String, dynamic> toMap() {
    Map map = {
      'email': this.email,
      'password': this.password,
    };
    return {...map};
  }
}
