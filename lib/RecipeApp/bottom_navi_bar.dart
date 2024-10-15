import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:recipe_app.example.com/RecipeApp/calender_screen.dart';
import 'package:recipe_app.example.com/RecipeApp/favorite_screen.dart';
// import 'package:recipe_app.example.com/RecipeApp/provider/onpagechanged.dart';
import 'package:recipe_app.example.com/RecipeApp/recipe_home_screen.dart';
import 'package:recipe_app.example.com/RecipeApp/settings_screen.dart';


class BottomNaviBar extends StatefulWidget {
  const BottomNaviBar({super.key});

  @override
  State<BottomNaviBar> createState() => _BottomNaviBarState();
}

class _BottomNaviBarState extends State<BottomNaviBar> {
  void _onTappedBar(int value) {
    setState(() {
      currentindex = value;
    });
    _pageController.jumpToPage(value);
  }

  var currentindex = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (value) {
          setState(() {
            currentindex = value;
          });
        },
        controller: _pageController,
        children: const <Widget>[
          RecipeHomeScreen(),
          FavoriteScreen(),
          CalenderScreen(),
          SettingScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        // onTap: _onTappedBar,
        // selectedItemColor: Colors.orange,
        // currentIndex: currentindex,
        useLegacyColorScheme: false,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
              icon: currentindex == 0
                  ? const Icon(Iconsax.home5)
                  : const Icon(Iconsax.home_1),
              label: "Home"),
          BottomNavigationBarItem(
              icon: currentindex == 1
                  ? const Icon(Iconsax.heart5)
                  : const Icon(Iconsax.heart),
              label: "Favorite"),
          BottomNavigationBarItem(
              icon: currentindex == 2
                  ? const Icon(Iconsax.calendar5)
                  : const Icon(Iconsax.calendar),
              label: "Calender"),
          BottomNavigationBarItem(
              icon: currentindex == 3
                  ? const Icon(Iconsax.setting_21)
                  : const Icon(Iconsax.setting_2),
              label: "Setting"),
        ],
        selectedItemColor: const Color.fromARGB(255, 24, 70, 151),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: currentindex,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            currentindex = value;
          });
          _pageController.jumpToPage(value);
        },

        enableFeedback: false,
      ),
    );
  }
}
