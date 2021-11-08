import 'dart:io';

// import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/Auth/helpers/auth_helper.dart';
import 'package:gsg_firebase/Auth/helpers/firestorage_helper.dart';
import 'package:gsg_firebase/Auth/helpers/firestore_helper.dart';
import 'package:gsg_firebase/Auth/models/countryModel.dart';
import 'package:gsg_firebase/Auth/models/register_request.dart';
import 'package:gsg_firebase/Auth/models/user_model.dart';
import 'package:gsg_firebase/Auth/ui/pages/main_page.dart';
import 'package:gsg_firebase/chats/pages/home_page.dart';
import 'package:gsg_firebase/services/routes_helper.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:record_mp3/record_mp3.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    getCountriesFromFirestore();
  }
  TabController tabController;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryNameController = TextEditingController();

  UserModel user;
  String myId;
  List<UserModel> users;
  getUserFromFirebase() async {
    String userId = AuthHelper.authHelper.getUserId();
    user = await FirestoreHelper.firestoreHelper.getUserFromFirestore(userId);
    notifyListeners();
  }

  getAllUsers() async {
    users = await FirestoreHelper.firestoreHelper.getAllUsersFromFirestore();
    users.removeWhere((e) => e.id == myId);
    notifyListeners();
  }

  resetControllers() {
    emailController.clear();
    passwordController.clear();
  }

//select country and city
  List<CountryModel> countries;
  List<dynamic> cities = [];
  CountryModel selectedCountry;
  String selectedCity;
  selectCountry(CountryModel countryModel) {
    this.selectedCountry = countryModel;
    this.cities = countryModel.cities;
    selectCity(cities.first.toString());
    notifyListeners();
  }

  selectCity(dynamic city) {
    this.selectedCity = city;
    notifyListeners();
  }

  getCountriesFromFirestore() async {
    List<CountryModel> countries =
        await FirestoreHelper.firestoreHelper.getAllCountries();
    this.countries = countries;
    selectCountry(countries.first);
    notifyListeners();
  }

//upload image to firebase
  File file;
  selectFile() async {
    XFile imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    this.file = File(imageFile.path);
    print(imageFile.path);
    notifyListeners();
  }

  register() async {
    try {
      UserCredential userCredential = await AuthHelper.authHelper
          .signup(emailController.text, passwordController.text);
      String imageUrl =
          await FirebaseStorageHelper.firebaseStorageHelper.uploadImage(file);
      RegisterRequest registerRequest = RegisterRequest(
        id: userCredential.user.uid,
        email: emailController.text,
        password: passwordController.text,
        city: selectedCity,
        country: selectedCountry.name,
        fName: firstNameController.text,
        lName: lastNameController.text,
        imageUrl: imageUrl,
      );
      await FirestoreHelper.firestoreHelper.addUserToFirestore(registerRequest);
      await AuthHelper.authHelper.verifyEmail();
      await AuthHelper.authHelper.logout();
      // RouteHelper.routeHelper.goToPageWithReplacement(LoginPage.routeName);
      tabController.animateTo(1);
    } on Exception catch (e) {
      print(e);
    }
    resetControllers();
  }

  login() async {
    UserCredential userCredential = await AuthHelper.authHelper
        .signin(emailController.text, passwordController.text);
    FirestoreHelper.firestoreHelper
        .getUserFromFirestore(userCredential.user.uid);
    RouteHelper.routeHelper.goToPageWithReplacement(HomePage.routeName);

    resetControllers();

    // .then((value) {
    // if (value) {
    //   //todo handle login
    //   bool isVerifiedEmail = AuthHelper.authHelper.checkEmailVerification();
    //   isVerifiedEmail
    //       ? RouteHelper.routeHelper
    //           .goToPageWithReplacement(HomePage.routeName)
    //       : CustomDialog.customDialog.showCustomDialog(
    //           'You have to verify your email, press ok to send another email',
    //           sendVericiafion);
    //   resetControllers();
    // } else {
    //   //todo handel error state
    //   CustomDialog.customDialog.showCustomDialog('Falid email or password');
    // }
    // });
  }

  sendVericiafion() {
    AuthHelper.authHelper.verifyEmail();
    AuthHelper.authHelper.logout();
  }

  resetPassword() async {
    AuthHelper.authHelper.resetPassword(emailController.text);
    resetControllers();
  }

  checkLogin() {
    bool isLoggedIn = AuthHelper.authHelper.checkUserLogin();
    if (isLoggedIn) {
      myId = AuthHelper.authHelper.getUserId();
      getAllUsers();
      RouteHelper.routeHelper.goToPageWithReplacement(HomePage.routeName);
    } else {
      RouteHelper.routeHelper.goToPageWithReplacement(AuthMainPage.routeName);
    }
  }

  logOut() async {
    await AuthHelper.authHelper.logout();
    RouteHelper.routeHelper.goToPageWithReplacement(AuthMainPage.routeName);
  }

  fillControllers() {
    firstNameController.text = user.fName;
    lastNameController.text = user.lName;
    cityController.text = user.city;
    countryNameController.text = user.country;
    emailController.text = user.email;
  }

  sendImageToChat([String message]) async {
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    String imageUrl = await FirebaseStorageHelper.firebaseStorageHelper
        .uploadImage(File(file.path), 'chats');
    FirestoreHelper.firestoreHelper.addMessagesToFirestore({
      'dateTime': DateTime.now(),
      'content': imageUrl ?? '',
      'type': 'image',
    });
  }

  File updatedfile;
  captureUpdateProfileImage() async {
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    this.updatedfile = File(file.path);
    notifyListeners();
  }

  updateProfile() async {
    String imageUrl, prevImage;
    // UserModel userModel;
    if (updatedfile != null) {
      imageUrl = await FirebaseStorageHelper.firebaseStorageHelper
          .uploadImage(updatedfile);
      // prevImage =
      //     await FirebaseStorageHelper.firebaseStorageHelper.uploadImage(file);

    }
    UserModel userModel = imageUrl == null
        ? UserModel(
            city: cityController.text,
            country: countryNameController.text,
            fName: firstNameController.text,
            lName: lastNameController.text,
            id: user.id,
          )
        : UserModel(
            city: cityController.text,
            country: countryNameController.text,
            fName: firstNameController.text,
            lName: lastNameController.text,
            id: user.id,
            imageUrl: imageUrl);

    await FirestoreHelper.firestoreHelper.updateProfile(userModel);
    getUserFromFirebase();
    Navigator.of(RouteHelper.routeHelper.navKey.currentContext).pop();
  }

  ///////////////////////////////////////////for voice
  int i = 0;
  String recordFilePath;
  bool isPlayingMsg = false, isSending = false, isRecording = false;

  sendAudioMsg(String recordFilePath) async {
    String audioMsg = await FirebaseStorageHelper.firebaseStorageHelper
        .uploadAudio(recordFilePath);
    FirestoreHelper.firestoreHelper.addMessagesToFirestore({
      'type': 'audio',
      'dateTime': DateTime.now(),
      'content': audioMsg ?? '',
    });
  }

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test_${i++}.mp3";
  }

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      recordFilePath = await getFilePath();

      RecordMp3.instance.start(recordFilePath, (type) {});
      isRecording = true;
    } else {
      print('no permission');
    }
    notifyListeners();
  }

  void stopRecord() async {
    bool s = RecordMp3.instance.stop();
    if (s) {
      isSending = true;
      sendAudioMsg(recordFilePath);
      isPlayingMsg = false;
    }
    notifyListeners();
  }

  Future<void> play() async {
    if (recordFilePath != null && File(recordFilePath).existsSync()) {
      AudioPlayer audioPlayer = AudioPlayer();
      await audioPlayer.play(
        recordFilePath,
        isLocal: true,
      );
    }
    notifyListeners();
  }

  Future loadFile(String url) async {
    Uri myUri = Uri.parse(url);
    final bytes = await readBytes(myUri);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/audio.mp3');

    await file.writeAsBytes(bytes);
    if (await file.exists()) {
      recordFilePath = file.path;
      isPlayingMsg = true;
      print(isPlayingMsg);
      notifyListeners();

      await play();

      isPlayingMsg = false;
    }
    notifyListeners();
  }
}
