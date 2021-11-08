// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:gsg_firebase/Auth/helpers/firestore_helper.dart';
// import 'package:gsg_firebase/Auth/models/user_model.dart';
// import 'package:gsg_firebase/chats/widges/user_widget.dart';

// //  FirestoreHelper.firestoreHelper.getAllUserFromFirestore();
// class HomePage extends StatefulWidget {
//   static final routeName = 'home';

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// // class _HomePageState extends State<HomePage> {
// //   // final Stream<QuerySnapshot> _usersStream =
// //   //     FirestoreHelper.firestoreHelper.getAllUserFromFirestore().snapshots();
// //   Future<dynamic> users;
// //   @override
// //   Widget build(BuildContext context) {
// //     users = FirestoreHelper.firestoreHelper.getAllUserFromFirestore();
// //     return Scaffold(
// //       body: ListView.builder(
// //         itemCount: users.length,
// //         // shrinkWrap: true,
// //         itemBuilder: (context, index) {
// //           return users[index] == null
// //               ? Text('theres no meetings exist')
// //               : UserWidget(users[index]);
// //           // return Container(
// //           //   child: Text(meetings[index].eventTitle),
// //           // );
// //         },
// //       ),
// //     );
// //   }
// // }
// class _HomePageState extends State<HomePage> {
//   final Stream<QuerySnapshot> _usersStream =
//       FirebaseFirestore.instance.collection('Users').snapshots();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("All users"),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _usersStream,
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Text('Something went wrong');
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Text("Loading");
//           }

//           return ListView(
//             children: snapshot.data.docs.map((DocumentSnapshot document) {
//               Map<String, dynamic> data =
//                   document.data() as Map<String, dynamic>;
//               return UserWidget(data);
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/chats/pages/chat_page.dart';
import 'package:gsg_firebase/chats/pages/profile_page.dart';
import 'package:gsg_firebase/chats/pages/users_page.dart';

class HomePage extends StatelessWidget {
  static final routeName = 'home';
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: ProfilePage(),
    // );
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [UserPage(), ProfilePage(), ChatPage()],
        ),
      ),
    );
  }
}
