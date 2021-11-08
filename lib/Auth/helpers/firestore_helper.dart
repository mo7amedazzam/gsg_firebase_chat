import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gsg_firebase/Auth/Providers/auth_provider.dart';
import 'package:gsg_firebase/Auth/helpers/auth_helper.dart';
import 'package:gsg_firebase/Auth/models/countryModel.dart';
import 'package:gsg_firebase/Auth/models/register_request.dart';
import 'package:gsg_firebase/Auth/models/user_model.dart';
import 'package:gsg_firebase/services/custom_dialog.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String message;

  Stream<QuerySnapshot<Map<String, dynamic>>> getFirestoreStream() {
    return firebaseFirestore
        .collection('Chats')
        .orderBy('dateTime')
        // .orderBy('dateTime') instead of sort
        .snapshots();
  }
  addMessagesToFirestore(Map map) async {
    firebaseFirestore
        .collection('Chats')
        .add({...map, 'userId': AuthHelper.authHelper.getUserId()});
  }
  addUserToFirestore(RegisterRequest registerRequest) async {
    try {
      // DocumentReference documentReference = await firebaseFirestore
      //     .collection('Users')
      //     .add(registerRequest.toMap());
      // print(documentReference.id);
      await firebaseFirestore
          .collection('Users')
          .doc(registerRequest.id)
          // .add(registerRequest.toMap());
          .set(registerRequest.toMap());
    } on Exception catch (e) {
      print(e);
    }
  }
  Future<UserModel> getUserFromFirestore(String userId) async {
    // firebaseFirestore.collection('Users').where('id', isEqualTo: userId).get();
    DocumentSnapshot documentSnapshot =
        await firebaseFirestore.collection('Users').doc(userId).get();
    // CustomDialog.customDialog
    //     .showCustomDialog(documentSnapshot.data.toString());
    print(documentSnapshot.data);
    return UserModel.fromMap(documentSnapshot.data());
  }
  Future<List<UserModel>> getAllUsersFromFirestore() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseFirestore.collection('Users').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = querySnapshot.docs;
    List<UserModel> users =
        docs.map((e) => UserModel.fromMap(e.data())).toList();
    print(users.length);
    return users;
  }
  Future<List<CountryModel>> getAllCountries() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseFirestore.collection('Countries').get();
    List<CountryModel> countries = querySnapshot.docs.map((e) {
      return CountryModel.fromJson(e.data());
    }).toList();
    return countries;
  }
  updateProfile(UserModel userModel) async {
    await firebaseFirestore
        .collection('Users')
        .doc(userModel.id)
        .update(userModel.toMap());
  }
}
