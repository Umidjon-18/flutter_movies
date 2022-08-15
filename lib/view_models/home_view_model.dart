import 'package:flutter/material.dart';

import '../services/local_db_services/theme_preferences.dart';
import '../utils/constants.dart';

class HomeViewModel extends ChangeNotifier {
  bool _isDark = false;
  ThemePreferences _preferences = ThemePreferences();
  bool get isDark => _isDark;

  HomeViewModel() {
    _isDark = false;
    _preferences = ThemePreferences();
    getPreferences();
  }
//Switching themes in the flutter apps - Flutterant
  set isDark(bool value) {
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }

  int bottomSelectedIndex = 0;
  bool searchFieldVisibilityInOrientation = false;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  TextEditingController searchController = TextEditingController();

  Widget buildPageView() {
    return PageView(
      physics: const BouncingScrollPhysics(),
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: Constants.pages,
    );
  }

  void pageChanged(int index) {
    bottomSelectedIndex = index;
    notifyListeners();
  }

  void bottomTapped(int index) {
    bottomSelectedIndex = index;
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
    notifyListeners();
  }

  void updatePage() {
    notifyListeners();
  }
}
