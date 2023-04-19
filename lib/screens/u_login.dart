import 'package:foodboard_application/screens/home_page.dart';
import 'package:foodboard_application/models/user_model.dart';
import 'package:foodboard_application/screens/recipe_details.dart';
import 'package:foodboard_application/screens/u_forgot_pass.dart';
import 'package:foodboard_application/screens/u_forgot_pass.dart';
import 'package:foodboard_application/screens/u_register.dart';
import 'package:foodboard_application/utils/colors.dart';
import 'package:foodboard_application/widgets/button_widget.dart';
import 'package:foodboard_application/widgets/textField_widget.dart';
import 'package:foodboard_application/widgets/big_text.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodboard_application/main.dart';
import 'package:passwordfield/passwordfield.dart';

// ignore: camel_case_types
class User_Login extends StatefulWidget {
  // final String loggedInUser;
  const User_Login({
    Key? key,
  }) : super(key: key);

  @override
  State<User_Login> createState() => _User_LoginState();
}

// ignore: camel_case_types
class _User_LoginState extends State<User_Login> {
  // Future<FirebaseApp> _initializeFirebase() async {
  //   FirebaseApp firebaseApp = await Firebase.initializeApp();
  //   return firebaseApp;
  // }

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

  bool isChecked = false;
  String? errorMessage;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  UserModel loggedInUser = UserModel();
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
                              width: 1, color: AppColors.lightGreyColor),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: AppColors.lightGreyColor),
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
                  //   size: 15,
                  //   text: 'Password *',
                  //   fontWeight: FontWeight.w400,
                  // ),
                  //
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
                          size: 15,
                          fontWeight: FontWeight.bold)
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Button_Widget(
                      text: "Sign in",
                      btn_width: 320,
                      pressed: () {
                        signIn();
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const User_Forgot_Pass()));
                    },
                    child: BigText(
                        text: "Forgot Password ?",
                        size: 16,
                        color: AppColors.mainColor,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BigText(
                      text: "or Continue with ",
                      color: AppColors.smallTextColor,
                      size: 16,
                      fontWeight: FontWeight.w500),
                  const SizedBox(
                    height: 20,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: <Widget>[
                  //     InkWell(
                  //         onTap: () {}, child: Image.asset("assets/f_btn.png")),
                  //     Image.asset("assets/g_btn.png"),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(left: 75),
                          child: BigText(
                            text: "Don't have an account?",
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
                                  builder: (context) => const User_Register()));
                        },
                        child: BigText(
                          text: "Sign up",
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

  // Login Function
  static Future<User?> loginusingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        Fluttertoast.showToast(msg: "No user Found with this Email Address");
      }
    }
    return user;
  }

  Future<void> signIn() async {
    if (_formKey.currentState!.validate()) {
      User? user = await loginusingEmailPassword(
          email: email.text, password: password.text, context: context);

      if (user != null) {
        try {
          CollectionReference db =
              FirebaseFirestore.instance.collection('users');
          FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get()
              .then((value) {
            loggedInUser = UserModel.fromMap(value.data());
            // ignore: unrelated_type_equality_checks
            if (loggedInUser.uid == []) {
              Fluttertoast.showToast(msg: "Malpractice found");
            } else {
              Fluttertoast.showToast(msg: "Login Successful");
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const RecipeDetails()));
            }
          });
        } on FirebaseAuthException catch (e) {
          print(e.message);
        }
      }
    }
  }
}
