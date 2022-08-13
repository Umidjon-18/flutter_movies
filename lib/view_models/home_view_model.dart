import 'package:flutter/material.dart';

import '../utils/constants.dart';

class HomeViewModel extends ChangeNotifier {
  int bottomSelectedIndex = 0;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
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
}
