import 'package:flutter/material.dart';
import 'package:gsg_firebase/Auth/Providers/auth_provider.dart';
import 'package:gsg_firebase/Auth/ui/pages/reset_password_page.dart';
import 'package:gsg_firebase/Auth/ui/widgets/custom_textfeild.dart';
import 'package:gsg_firebase/global_widget.dart/custome_button.dart';
import 'package:gsg_firebase/services/routes_helper.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static final routeName = 'login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (contex, provider, x) {
          return Column(
            children: [
              CustomrTextFeild('Email', provider.emailController),
              CustomrTextFeild('Password', provider.passwordController),
              CustomButton('login', provider.login),
              GestureDetector(
                onTap: () {
                  RouteHelper.routeHelper.goToPage(ResetPassordPage.routeName);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 10,
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
