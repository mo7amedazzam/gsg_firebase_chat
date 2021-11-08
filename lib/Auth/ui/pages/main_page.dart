import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/Auth/Providers/auth_provider.dart';
import 'package:gsg_firebase/Auth/ui/pages/login_page.dart';
import 'package:gsg_firebase/Auth/ui/pages/register_page.dart';
import 'package:provider/provider.dart';

class AuthMainPage extends StatefulWidget {
  static final routeName = 'authPage';
  @override
  _AuthMainPageState createState() => _AuthMainPageState();
}

class _AuthMainPageState extends State<AuthMainPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  initTabController() {
    // tabController = TabController(length: 2, vsync: this);
    Provider.of<AuthProvider>(context, listen: false).tabController =
        TabController(length: 2, vsync: this);
  }

  @override
  void initState() {
    super.initState();
    initTabController();
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
        // toolbarHeight: height * 0.3,
        bottom: TabBar(
          controller: Provider.of<AuthProvider>(context).tabController,
          tabs: [
            Tab(
              text: 'Register',
            ),
            Tab(
              text: 'Login',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: Provider.of<AuthProvider>(context).tabController,
        children: [
          RegisterPage(),
          LoginPage(),
        ],
      ),
      // body: Stack(
      //   children: <Widget>[
      //     //First thing in the stack is the background

      //     Container(
      //       height: height * 0.3,
      //       decoration: const BoxDecoration(
      //         gradient: const LinearGradient(
      //           begin: Alignment.topCenter,
      //           end: Alignment
      //               .bottomCenter, // 10% of the width, so there are ten blinds.
      //           colors: const <Color>[
      //             Color(0xff4d47fe),
      //             Color(0xff5db5ff)
      //           ], // red to yellow
      //           tileMode:
      //               TileMode.repeated, // repeats the gradient over the canvas
      //         ),
      //       ),
      //     ),
      //     //For the backgroud i create a column
      //     Center(
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: <Widget>[
      //           DecoratedBox(
      //             decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(20.0),
      //                 color: Colors.white),
      //             child: Container(
      //               alignment: Alignment.topCenter,
      //               width: 300.0,
      //               height: 400.0,
      //               child: TabBar(
      //                 controller:
      //                     Provider.of<AuthProvider>(context).tabController,
      //                 labelColor: Colors.blue,
      //                 tabs: [
      //                   Tab(
      //                     text: 'Register',
      //                   ),
      //                   Tab(
      //                     text: 'Login',
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //           TabBarView(
      //             controller: Provider.of<AuthProvider>(context).tabController,
      //             children: [
      //               RegisterPage(),
      //               LoginPage(),
      //             ],
      //           )
      //           //second item in the column is a transparent space of 20
      //           // Container(height: 20.0),
      //         ],
      //       ),
      //     ),
      //     Column(
      //       children: [],
      //     )
      //     //for the button i create another column
      //   ],
      // ),
    );
  }
}
