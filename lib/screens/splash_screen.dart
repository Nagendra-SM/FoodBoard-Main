import 'package:foodboard_application/utils/config.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // init state
  @override
  void initState() {
    // final sp = context.read<SignInProvider>();
    super.initState();
    // create a timer of 2 seconds
    // Timer(const Duration(seconds: 2), () {
    //   sp.isSignedIn == false
    //       ? nextScreen(context, const User_Login())
    //       : nextScreen(context, HomePage());
    // });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
            child: Image(
          image: AssetImage(Config.appIcon),
          height: 80,
          width: 80,
        )),
      ),
    );
  }
}
