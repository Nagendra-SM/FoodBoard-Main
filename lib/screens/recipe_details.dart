import 'package:flutter/material.dart';
import 'package:foodboard_application/screens/favorite_Screen.dart';
import 'package:foodboard_application/screens/filter_chip_display.dart';
import 'package:foodboard_application/screens/settings_screen.dart';

import 'package:foodboard_application/screens/home_page.dart';
import 'package:foodboard_application/screens/recipe_body.dart';
import 'package:foodboard_application/screens/search_page.dart';
import 'package:foodboard_application/utils/colors.dart';
import 'package:foodboard_application/widgets/hotels_card.dart';

class RecipeDetails extends StatefulWidget {
  const RecipeDetails({Key? key}) : super(key: key);

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    HomePage(),
    FilterChipDisplay(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _children[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: AppColors.lightGreyColor,
        elevation: 5.0,
        currentIndex: _currentIndex,
        //type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.white,
          ),
        ],
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
