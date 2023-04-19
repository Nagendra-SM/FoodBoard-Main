import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodboard_application/widgets/big_text.dart';
import 'package:passwordfield/passwordfield.dart';

import '../utils/colors.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var loggedInUser;

  final FirebaseAuth auth = FirebaseAuth.instance;
  String? gender;

  @override
  void initState() {
    super.initState();
    inputData();
  }

  Future<void> inputData() async {
    final User? user = auth.currentUser;
    final uid = user?.uid;

    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      setState(() {
        loggedInUser = data?['username']; // <-- The value you want to retrieve.
      });
      print(loggedInUser);
      // Call setState if needed.
    }
  }

  Future<void> updateProfileData() async {
    final User? user = auth.currentUser;
    final uid = user?.uid;

    final _updateProfiledb = FirebaseFirestore.instance.collection('users');
    await _updateProfiledb.doc(uid).update({
      'username': usernameController.text,
      'gender': gender,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(
          text: "Edit Profile Information",
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Wrap(children: [
          Container(
            color: Colors.white,
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              SimpleUserCard(
                userName: '$loggedInUser',
                userProfilePic: const AssetImage("assets/userProfile.png"),
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 10, 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: usernameController,
                          //autofocus: true,
                          autocorrect: true,
                          maxLines: 1,
                          obscureText: false,
                          textCapitalization: TextCapitalization.words,
                          //keyboardType: TextInputType.streetAddress,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          cursorColor: const Color.fromARGB(255, 86, 85, 82),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 86, 85, 82)),
                            ),
                            hintText: "UserName",
                            contentPadding: EdgeInsets.fromLTRB(15, 28, 0, 10),
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 86, 85, 82),
                                fontSize: 15),
                            hintMaxLines: 1,
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Column(
                          children: [
                            DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 192, 183, 183),
                                    width: 1.3,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: const <BoxShadow>[
                                    BoxShadow(
                                        color: Color.fromRGBO(255, 255, 255,
                                            0.569), //shadow for button
                                        blurRadius: 5) //blur radius of shadow
                                  ]),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(14, 4, 10, 4),
                                child: DropdownButton<String>(
                                  elevation: 8,
                                  // Initial Value
                                  value: gender,

                                  hint: const Text(
                                    "Select Gender",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 86, 85, 82)),
                                  ),
                                  isExpanded: true,
                                  underline: Container(),

                                  iconEnabledColor:
                                      Color.fromARGB(255, 108, 107, 104),
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black),
                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),

                                  // Array list of items
                                  items: <String>['Male', 'Female', 'Other']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      gender = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Center(
                          child: ElevatedButton(
                            child: const Text('Update'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shadowColor:
                                  const Color.fromARGB(255, 185, 173, 172),
                              elevation: 4,
                              padding: const EdgeInsets.all(18),
                              minimumSize: const Size.fromHeight(40),
                            ),
                            onPressed: () {
                              updateProfileData();
                              usernameController.clear();
                            },
                          ),
                        )
                      ]),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
