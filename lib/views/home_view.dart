import 'package:flutter/material.dart';
import 'package:fluttery_filmy/view_models/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
 
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (BuildContext context, homeViewModel, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Flutter Movies',
              style: TextStyle(fontSize: 25),
            ),
          ),
          body: homeViewModel.buildPageView(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: homeViewModel.bottomSelectedIndex,
            onTap: (index) {
              homeViewModel.bottomTapped(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.chair_rounded),
                label: 'Now Playing',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'Upcoming',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Popular',
              ),
            ],
          ),
        );
      },
    );
  }
}
