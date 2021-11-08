import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/Auth/Providers/auth_provider.dart';
import 'package:gsg_firebase/chats/pages/update_profile.dart';
import 'package:gsg_firebase/chats/widges/item_widget.dart';
import 'package:gsg_firebase/services/routes_helper.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  static final routeName = 'profile';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).getUserFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false)
                    .fillControllers();
                RouteHelper.routeHelper.goToPage(UpdateProfile.routeName);
              },
              icon: Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).logOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Consumer<AuthProvider>(
        builder: (context, provider, x) {
          return provider.user == null
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      provider.user.imageUrl == null
                          ? CircleAvatar(
                              // height: 200,
                              // width: 200,
                              // backgroundColor: Colors.grey,
                              backgroundImage: AssetImage(
                                  'assets/images/defaultProfileImage.png'),
                              radius: 70,
                            )
                          : CircleAvatar(
                              // height: 200,
                              // width: 200,
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(
                                provider.user.imageUrl,
                              ),
                              radius: 70,
                            ),
                      ItemWidget('Email', provider.user.email),
                      ItemWidget('First Name', provider.user.fName),
                      ItemWidget('Last Name', provider.user.lName),
                      ItemWidget('City', provider.user.city),
                      ItemWidget('Country', provider.user.country),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
