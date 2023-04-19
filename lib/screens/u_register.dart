import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodboard_application/models/user_model.dart';
import 'package:foodboard_application/screens/u_login.dart';
import 'package:foodboard_application/utils/colors.dart';
import 'package:foodboard_application/widgets/button_widget.dart';
import 'package:foodboard_application/widgets/textField_widget.dart';
import 'package:foodboard_application/widgets/big_text.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:passwordfield/passwordfield.dart';

// ignore: camel_case_types
class User_Register extends StatefulWidget {
  const User_Register({Key? key}) : super(key: key);

  @override
  State<User_Register> createState() => _User_RegisterState();
}

// ignore: camel_case_types
class _User_RegisterState extends State<User_Register> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return AppColors.mainColor;
  }

  final _formKey = GlobalKey<FormState>();

  bool isChecked = false;
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  UserModel user = UserModel();
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 250,
                    child: Center(
                      child: Image.asset("assets/header.png"),
                    ),
                  ),
                  Field_Widget(
                    type: TextInputType.name,
                    control: username,
                    hint: "Name",
                    valid: (value) {
                      RegExp regex = RegExp(r"^[a-zA-Z'-. ]+$");

                      if (value!.isEmpty) {
                        return ("Name is required for registering admin");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Name must not contain numbers");
                      }
                      return null;
                    },
                    color: Colors.black,
                    size: 15,
                    text: 'Name *',
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Field_Widget(
                    type: TextInputType.emailAddress,
                    control: email,
                    hint: "Email",
                    valid: (value) {
                      if (value!.isEmpty) {
                        return ("Please Enter your Email");
                      }
                      //reg expression for email
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Please Enter the valid Email");
                      }
                      return null;
                    },
                    color: Colors.black,
                    size: 15,
                    text: 'Email *',
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 40, bottom: 13),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Password *',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  Container(
                    width: 315,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4), //shadow color
                          blurRadius: 7, // shadow blur radius
                          offset:
                              const Offset(0, 4), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: PasswordField(
                      backgroundColor: Colors.white,
                      controller: password,
                      color: Colors.blue,
                      passwordConstraint: r'.*[@$#.*].*{8}',
                      inputDecoration: PasswordDecoration(
                          inputStyle: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15)),
                      hintText: 'Password',
                      border: PasswordBorder(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 203, 201, 201)),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2, color: AppColors.lightGreyColor),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 6, 135, 199)),
                        ),
                      ),
                      errorMessage:
                          'must contain special character either . * @ # \$',
                    ),
                  ),
                  // Field_Widget(
                  //   type: TextInputType.visiblePassword,
                  //   control: password,
                  //   hint: "Password",
                  //   valid: (value) {
                  //     RegExp regex = RegExp(r'^.{6,}$');

                  //     if (value!.isEmpty) {
                  //       return ("Password is required for login");
                  //     }
                  //     if (!regex.hasMatch(value)) {
                  //       return ("Enter Valid Password(Min. 6 Character)");
                  //     }
                  //     return null;
                  //   },
                  //   color: Colors.black,
                  //   size: 15,
                  //   text: 'Password *',
                  //   fontWeight: FontWeight.w400,
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 25),
                        child: Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      BigText(
                          text: "Remember me",
                          color: Colors.black87,
                          size: 15,
                          fontWeight: FontWeight.bold)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Button_Widget(
                      text: "Register",
                      btn_width: 320,
                      pressed: () {
                        registerUser(username.text, email.text, password.text);
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  BigText(
                      text: "or Continue with ",
                      color: Colors.grey,
                      size: 16,
                      fontWeight: FontWeight.w500),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(left: 75),
                          child: BigText(
                            text: "Already have an account?",
                            size: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const User_Login()));
                        },
                        child: BigText(
                          text: "Sign in",
                          size: 15,
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> registerUser(
      String username, String email, String password) async {
    try {
      // Check if email already exists in Firestore collection 'users'
      QuerySnapshot snapshot =
          await usersCollection.where('email', isEqualTo: email).get();
      if (snapshot.docs.isNotEmpty) {
        Fluttertoast.showToast(msg: 'User with email $email already exists');
        return;
      }
      // Create user with email and password in Firebase Authentication
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? newUser = result.user;

      // Store additional user details in Firestore collection 'users'
      if (newUser != null) {
        UserModel user = UserModel(
            uid: newUser.uid,
            username: username,
            email: email,
            password: password);
        await usersCollection.doc(newUser.uid).set(user.toMap());
        Fluttertoast.showToast(msg: 'User registered successfully');
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const User_Login()));
      }
    } catch (e) {
      print('Error registering user: $e');
    }
  }
}
