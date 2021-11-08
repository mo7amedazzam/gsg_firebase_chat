import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/Auth/Providers/auth_provider.dart';
import 'package:gsg_firebase/Auth/ui/widgets/custom_textfeild.dart';
import 'package:gsg_firebase/global_widget.dart/custome_button.dart';
import 'package:provider/provider.dart';

class ResetPassordPage extends StatelessWidget {
  static final routeName = 'reset';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Consumer<AuthProvider>(
        builder: (contex, provider, x) {
          return Column(
            children: [
              CustomrTextFeild('Email', provider.emailController),
              CustomButton('Reset password', provider.resetPassword),
            ],
          );
        },
      ),
    );
  }
}
