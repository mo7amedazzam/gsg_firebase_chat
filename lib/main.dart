import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/Auth/Providers/auth_provider.dart';
import 'package:gsg_firebase/Auth/ui/pages/login_page.dart';
import 'package:gsg_firebase/Auth/ui/pages/main_page.dart';
import 'package:gsg_firebase/Auth/ui/pages/register_page.dart';
import 'package:gsg_firebase/Auth/ui/pages/reset_password_page.dart';
import 'package:gsg_firebase/Auth/ui/pages/splash_screen.dart';
import 'package:gsg_firebase/chats/pages/chat_page.dart';
import 'package:gsg_firebase/chats/pages/profile_page.dart';
import 'package:gsg_firebase/chats/pages/update_profile.dart';
import 'package:gsg_firebase/chats/pages/users_page.dart';
import 'package:gsg_firebase/services/routes_helper.dart';
import 'package:provider/provider.dart';

import 'chats/pages/home_page.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized(); //when exist onther code to execute
  runApp(
    ChangeNotifierProvider<AuthProvider>(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        routes: {
          LoginPage.routeName: (context) => LoginPage(),
          RegisterPage.routeName: (context) => RegisterPage(),
          ResetPassordPage.routeName: (context) => ResetPassordPage(),
          HomePage.routeName: (context) => HomePage(),
          AuthMainPage.routeName: (context) => AuthMainPage(),
          UserPage.routeName: (context) => UserPage(),
          ProfilePage.routeName: (context) => ProfilePage(),
          UpdateProfile.routeName: (context) => UpdateProfile(),
          ChatPage.routeName: (context) => ChatPage(),
        },
        navigatorKey: RouteHelper.routeHelper.navKey,
        home: FirebaseConfiguration(),
      ),
    ),
  );
}

class FirebaseConfiguration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, AsyncSnapshot<FirebaseApp> dataSnapShot) {
          if (dataSnapShot.hasError) {
            return Scaffold(
              backgroundColor: Colors.red,
              body: Center(
                child: Text(dataSnapShot.error.toString()),
              ),
            );
          }
          if (dataSnapShot.connectionState == ConnectionState.done) {
            // return AuthMainPage();
            return SplashScreen();
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
