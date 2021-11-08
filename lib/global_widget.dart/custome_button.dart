import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Function onPressed;
  String label;
  CustomButton(this.label, this.onPressed);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        child: Text(label),
      ),
    );
  }
}
