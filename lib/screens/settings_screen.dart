import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:foodboard_application/screens/about_screen.dart';
import 'package:foodboard_application/screens/edit_profile.dart';
import 'package:foodboard_application/screens/send_feedback.dart';
import 'package:foodboard_application/screens/u_login.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var loggedInUser;

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

      // Call setState if needed.
    }
  }

  @override
  Widget build(BuildContext context) {
    final users = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            // user card
            SimpleUserCard(
              userName: '$loggedInUser',
              userProfilePic: const AssetImage("assets/userProfile.png"),
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfilePage()),
                    );
                  },
                  icons: CupertinoIcons.pencil_outline,
                  iconStyle: IconStyle(),
                  title: 'Edit',
                  subtitle: "Edit Profile Information",
                ),
                SettingsItem(
                  onTap: () {
                    _showFeedback(context);
                  },
                  icons: Icons.feedback,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: const Color.fromARGB(255, 233, 145, 12),
                  ),
                  title: 'Send Feedback',
                  subtitle: "Send Feedbacks To Improve",
                ),
                SettingsItem(
                  onTap: () async {
                    final appUrl = 'www.google.com';
                    await Share.share(
                        'com.example.foodboard_application\n\n$appUrl');
                  },
                  icons: Icons.share_rounded,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: const Color.fromARGB(255, 12, 233, 30),
                  ),
                  title: 'Invite Friends',
                  subtitle: "Invite your frineds and family",
                ),
                SettingsItem(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutScreen()),
                    );
                  },
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'About',
                  subtitle: "Learn more about FoodBoard App",
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            SettingsGroup(
              settingsGroupTitle: "Account",
              items: [
                SettingsItem(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const User_Login()));
                  },
                  icons: Icons.exit_to_app_rounded,
                  title: "Sign Out",
                ),
                SettingsItem(
                  onTap: () {
                    deleteAccount();
                  },
                  icons: CupertinoIcons.delete_solid,
                  title: "Delete account",
                  titleStyle: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              'From',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.4),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'FoodBoard',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.4),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _showFeedback(context) {
    showDialog(context: context, builder: (context) => const FeedbackDialog());
  }

  Future<void> deleteAccount() async {
    var email;
    var password;
    final User? user = auth.currentUser;
    final uid = user?.uid;

    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(uid).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      email = data?['email'];
      password = data?['password'];
      var docReference = await collection.doc(uid);
      docReference.delete();
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      await user?.reauthenticateWithCredential(credential).then((value) {
        value.user?.delete().then((res) async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const User_Login()),
          );
        });
      });

      // Call setState if needed.
    }
  }
}
