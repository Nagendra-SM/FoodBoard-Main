import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodboard_application/widgets/big_text.dart';
import 'package:passwordfield/passwordfield.dart';

import '../utils/colors.dart';

class AboutScreen extends StatelessWidget {
  List used = [
    'Flutter Framework',
    'Dart Programming Language',
    'Firebase Firestore Cloud Database',
    'Api'
  ];
  List usedDesc = [
    'Flutter – a simple and high performance framework based on Dart language, provides high performance by rendering the UI directly in the operating system’s canvas rather than through native framework.Flutter also offers many ready to use widgets (UI) to create a modern application. These widgets are optimized for mobile environment and designing the application using widgets is as simple as designing HTML.To be specific, Flutter application is itself a widget. Flutter widgets also supports animations and gestures. The application logic is based on reactive programming. Widget may optionally have a state. By changing the state of the widget, Flutter will automatically (reactive programming) compare the widget’s state (old and new) and render the widget with only the necessary changes instead of re-rendering the whole widget.',
    'Dart is a general-purpose, high-level modern programming language which is originally developed by Google. It is the new programming language which is emerged in 2011, but its stable version was released in June 2017. Dart is not so popular at that time, but It gains popularity when it is used by the Flutter.Dart is a dynamic, class-based, object-oriented programming language with closure and lexical scope. Syntactically, it is quite similar to Java, C, and JavaScript. If you know any of these programming languages, you can easily learn the Dart programming language.Dart is an open-source programming language which is widely used to develop the mobile application, modern web-applications, desktop application, and the Internet of Things (IoT) using by Flutter framework. It also supports a few advance concepts such as interfaces, mixins, abstract classes, refield generics, and type interface. It is a compiled language and supports two types of compilation techniques.',
    'Cloud Firestore is a flexible as well as scalable NoSQL cloud database. It is used to store and sync data for client and server-side development. It is used for mobile, web, and server development from Google Cloud Platform and Firebase. Like the Firebase Real-time Database, it keeps syncing our data via real-time listeners to the client app. It provides offline support for mobile and web so we can create responsive apps that work regardless of network latency or Internet connectivity.Cloud Firestore also provides seamless integration with Google Cloud Platform products and other Firebase, including cloud functions.',
    'API stands for “Application Programming Interface”. In the simplest terms an API is just a structured way for software applications to communicate with each other.An API can give you access to the services or data available from another software application. When the application receives a specially formatted request - referred to as an API call - it responds by providing the requested service or data in a way that can be integrated into other applications or workflows.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(
          text: "FoodBoard",
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
                userName: 'FoodBoard',
                userProfilePic: const AssetImage("assets/header.png"),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: const TextSpan(children: [
                    TextSpan(
                      text: 'About FoodBoard\n',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                    WidgetSpan(
                      child: SizedBox(height: 40),
                    ),
                    TextSpan(
                      text:
                          'Food Board is an innovative solution that provides end-users with a platform to find recipes, order food from nearby restaurants, and connect with other foodies.The project aims to simplify the food industry by providing a user-friendly interface and integrating third-party services.The applications primary objective is to provide convenience to users and reduce the effort required to find recipes and order food.\n',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text("Technology Used For Development",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20)),
                    ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (BuildContext context, index) {
                          return RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(children: [
                              TextSpan(
                                text: '\n${used[index]}\n',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18),
                              ),
                              const WidgetSpan(
                                child: SizedBox(height: 40),
                              ),
                              TextSpan(
                                text: usedDesc[index],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              const WidgetSpan(
                                child: SizedBox(height: 20),
                              ),
                            ]),
                          );
                        }),
                  ])),
              const SizedBox(
                height: 20,
              )
            ]),
          ),
        ]),
      ),
    );
  }
}
