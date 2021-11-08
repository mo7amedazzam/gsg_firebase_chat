import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFeildWidget extends StatelessWidget {
  String label;
  TextEditingController valueController;
  TextFeildWidget(this.label, this.valueController);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: TextField(
              controller: valueController,
              style: TextStyle(fontSize: 22),
            ),
          ),
        ],
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
    );
  }
}
