import 'package:firebase_auth/firebase_auth.dart';
import 'package:gsg_firebase/services/custom_dialog.dart';

class AuthHelper {
  AuthHelper._();
  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String getUserId() {
    return firebaseAuth.currentUser.uid;
  }

  Future<UserCredential> signup(String email, String password) async {
    try {
      //User Credintial: user information to dermine the user
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
      // print(await userCredential.user.getIdToken());
      // print(userCredential.user.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomDialog.customDialog
            .showCustomDialog('The password provided is too weak.');
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        CustomDialog.customDialog
            .showCustomDialog('The account already exists for that email.');
        // print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<UserCredential> signin(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
      // print(await userCredential.user.getIdToken());
      // print(userCredential.user.uid);

      //   if (userCredential.user.uid != null) {
      //     print(" userLogin ${userCredential.user.uid}");
      //     return true;
      //   } else {
      //     print(" userLogin ${userCredential.user.uid}");
      //     return false;
      //   }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomDialog.customDialog
            .showCustomDialog('No user found for that email.');
        // print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        CustomDialog.customDialog
            .showCustomDialog('Wrong password provided for that user.');
        // print('Wrong password provided for that user.');
      }
      //   return false;
    }
  }

  resetPassword(String email) async {
    firebaseAuth.sendPasswordResetEmail(email: email);
    CustomDialog.customDialog.showCustomDialog(
        'we have sent email for reset password. please check your email');
  }

  verifyEmail() async {
    await firebaseAuth.currentUser.sendEmailVerification();
    CustomDialog.customDialog.showCustomDialog(
        'verification email has been send, please check your email');
    // print('verification email has been send');
  }

  logout() async {
    firebaseAuth.signOut();
  }

  // User getCurrentUser() {
  //   User user = firebaseAuth.currentUser;
  //   print(user.email);
  //   print(user.uid);
  //   user.getIdToken().then((value) => print(value));
  //   return user;
  // }
  bool checkEmailVerification() {
    return firebaseAuth.currentUser?.emailVerified ?? false;
  }

  bool checkUserLogin() {
    if (firebaseAuth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }
}
