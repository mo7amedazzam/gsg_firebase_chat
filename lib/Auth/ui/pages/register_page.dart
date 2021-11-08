import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/Auth/Providers/auth_provider.dart';
import 'package:gsg_firebase/Auth/helpers/auth_helper.dart';
import 'package:gsg_firebase/Auth/models/countryModel.dart';
import 'package:gsg_firebase/Auth/ui/widgets/custom_textfeild.dart';
import 'package:gsg_firebase/global_widget.dart/custome_button.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  static final routeName = 'register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (contex, provider, x) {
          return SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    provider.selectFile();
                  },
                  child: CircleAvatar(
                    // height: 200,
                    // width: 200,
                    backgroundColor: Colors.grey,
                    backgroundImage: provider.file == null
                        ? AssetImage('assets/images/defaultProfileImage.png')
                        : FileImage(
                            provider.file,
                          ),
                    radius: 70,
                  ),
                ),
                CustomrTextFeild('FirstName', provider.firstNameController),
                CustomrTextFeild('LastName', provider.lastNameController),
                CustomrTextFeild('Email', provider.emailController),
                CustomrTextFeild('Password', provider.passwordController),
                provider.countries == null
                    ? Container(
                        child: Text('theres no countries'),
                      )
                    : Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton<CountryModel>(
                          isDense: true,
                          isExpanded: true,
                          value: provider.selectedCountry == null
                              ? 'Select Country'
                              : provider.selectedCountry,
                          onChanged: (x) {
                            provider.selectCountry(x);
                          },
                          items: provider.countries.map((e) {
                            return DropdownMenuItem<CountryModel>(
                              child: Text(e.name) == null
                                  ? Text('Palestine')
                                  : Text(e.name),
                              value: e,
                            );
                          }).toList(),
                        ),
                      ),
                provider.cities == null
                    ? Container(
                        child: Text('theres no countries'),
                      )
                    : Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton<dynamic>(
                          isDense: true,
                          isExpanded: true,
                          value: provider.selectedCity,
                          onChanged: (x) {
                            provider.selectCity(x);
                          },
                          items: provider.cities.map((e) {
                            return DropdownMenuItem<dynamic>(
                              child: Text(e),
                              value: e,
                            );
                          }).toList(),
                        ),
                      ),
                CustomButton('Register', provider.register),
              ],
            ),
          );
        },
      ),
    );
  }
}
