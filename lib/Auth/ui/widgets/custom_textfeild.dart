import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomrTextFeild extends StatelessWidget {
  String label;
  TextEditingController controller;
  CustomrTextFeild(this.label, this.controller);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: TextField(
        controller: this.controller,
        decoration: InputDecoration(
          labelText: this.label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
