import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gsg_firebase/Auth/Providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  // const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2)).then(
      (value) {
        Provider.of<AuthProvider>(context, listen: false).checkLogin();
      },
    );
    return Scaffold(
      body: Center(
        child: Text('Splach Screen'),
      ),
    );
  }
}
