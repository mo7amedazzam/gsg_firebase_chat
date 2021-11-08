import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/Auth/models/user_model.dart';

class UserWidget extends StatefulWidget {
  Map<String, dynamic> user;
  UserWidget(this.user);
  @override
  _UserWidgetState createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width > 600 ? size.width * 0.6 : size.width,
      height: size.width > 600 ? size.height * 0.9 : size.height * 0.28,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            shape: Border(
              left: BorderSide(
                width: 5,
              ),
            ),
            margin: EdgeInsets.symmetric(
              vertical: size.height * 0.02,
              horizontal: size.width * 0.04,
            ),
            elevation: 1,
            child: ListTile(
              title: Container(
                height:
                    size.width > 600 ? size.height * 0.2 : size.height * 0.1,
                margin: EdgeInsets.symmetric(
                  vertical: size.height * 0.03,
                  horizontal: size.width * 0.02,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: size.height * 0.018),
                      child: Text(
                        ' ${widget.user['fname']} ${widget.user['lname']}',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          bottom: size.width > 600
                              ? size.width * 0.01
                              : size.height * 0.01),
                      child: Text(
                        ' ${widget.user['country']} - ${widget.user['city']}',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
