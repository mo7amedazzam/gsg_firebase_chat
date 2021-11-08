import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/Auth/Providers/auth_provider.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  static final routeName = 'users';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Users'),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, provider, x) {
          return provider.users == null
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: provider.users.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                NetworkImage(provider.users[index].imageUrl),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Column(
                            children: [
                              Text(provider.users[index].fName +
                                  ' ' +
                                  provider.users[index].lName),
                              Text(provider.users[index].email),
                              Text(provider.users[index].country +
                                  '-' +
                                  provider.users[index].city),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
        },
      ),
    );
  }
}
