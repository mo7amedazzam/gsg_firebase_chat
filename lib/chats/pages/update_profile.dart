import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/Auth/Providers/auth_provider.dart';
import 'package:gsg_firebase/chats/widges/item_widget.dart';
import 'package:gsg_firebase/chats/widges/text_feild.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  static final routeName = 'updateProfile';

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Editing Profile'),
          actions: [
            IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false)
                    .updateProfile();
              },
              icon: Icon(Icons.done),
            )
          ],
        ),
        body: Consumer<AuthProvider>(builder: (context, provider, x) {
          return SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    provider.captureUpdateProfileImage();
                  },
                  child: CircleAvatar(
                    // height: 200,
                    // width: 200,
                    backgroundColor: Colors.grey,
                    backgroundImage: provider.updatedfile != null
                        ? FileImage(provider.updatedfile)
                        : NetworkImage(
                            provider.user.imageUrl,
                          ),
                    radius: 70,
                  ),
                ),
                TextFeildWidget('First Name', provider.firstNameController),
                TextFeildWidget('Last Name', provider.lastNameController),
                TextFeildWidget('City', provider.cityController),
                TextFeildWidget('Country', provider.countryNameController),
              ],
            ),
          );
        }));
  }
}
