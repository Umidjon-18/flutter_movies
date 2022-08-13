import 'package:flutter/material.dart';
import 'package:fluttery_filmy/view_models/home_view_model.dart';
import 'package:fluttery_filmy/view_models/now_playing_view_model.dart';
import 'package:fluttery_filmy/view_models/upcoming_view_model.dart';
import 'package:provider/provider.dart';

import '../view_models/popular_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<HomeViewModel>(
      builder: (BuildContext context, homeViewModel, Widget? child) {
        
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Flutter Movies',
              style: TextStyle(fontSize: 25),
            ),
            actions: [
              PopupMenuButton(
                  icon: const Icon(Icons.sort),
                  iconSize: 30,
                  // Callback that sets the selected popup menu item.
                  onSelected: (item) {},
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                        PopupMenuItem(
                          value: "popularity",
                          child: const Text('Sort by Popularity'),
                          onTap: () {
                            switch (homeViewModel.bottomSelectedIndex) {
                              case 0:
                                context
                                    .read<NowPlayingViewModel>()
                                    .sortByPopularity();
                                break;
                              case 1:
                                context
                                    .read<UpcomingViewModel>()
                                    .sortByPopularity();
                                break;
                              case 2:
                                context
                                    .read<PopularViewModel>()
                                    .sortByPopularity();
                                break;
                              default:
                            }
                          },
                        ),
                        PopupMenuItem(
                          value: "rate",
                          child: const Text('Sort by Rate'),
                          onTap: () {
                            switch (homeViewModel.bottomSelectedIndex) {
                              case 0:
                                context
                                    .read<NowPlayingViewModel>()
                                    .sortByRate();
                                break;
                              case 1:
                                context.read<UpcomingViewModel>().sortByRate();
                                break;
                              case 2:
                                context.read<PopularViewModel>().sortByRate();
                                break;
                              default:
                            }
                          },
                        ),
                        PopupMenuItem(
                          value: "date",
                          child: const Text('Sort by Date'),
                          onTap: () {
                            switch (homeViewModel.bottomSelectedIndex) {
                              case 0:
                                context
                                    .read<NowPlayingViewModel>()
                                    .sortByDate();
                                break;
                              case 1:
                                context.read<UpcomingViewModel>().sortByDate();
                                break;
                              case 2:
                                context.read<PopularViewModel>().sortByDate();
                                break;
                              default:
                            }
                          },
                        ),
                        PopupMenuItem(
                          value: "vote",
                          child: const Text('Sort by Vote'),
                          onTap: () {
                            switch (homeViewModel.bottomSelectedIndex) {
                              case 0:
                                context
                                    .read<NowPlayingViewModel>()
                                    .sortByVote();
                                break;
                              case 1:
                                context.read<UpcomingViewModel>().sortByVote();
                                break;
                              case 2:
                                context.read<PopularViewModel>().sortByVote();
                                break;
                              default:
                            }
                          },
                        ),
                      ])
            ],
            bottom: PreferredSize(
              preferredSize: Size(size.width, size.height * 0.04),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 9,
                      child: Container(
                        width: double.infinity,
                        height: size.height * 0.04,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          autocorrect: false,
                          autofocus: false,
                          controller: homeViewModel.searchController,
                          onChanged: (String text) {
                            switch (homeViewModel.bottomSelectedIndex) {
                              case 0:
                                context
                                    .read<NowPlayingViewModel>()
                                    .searchMovie(text);
                                break;
                              case 1:
                                context
                                    .read<UpcomingViewModel>()
                                    .searchMovie(text);
                                break;
                              case 2:
                                context
                                    .read<PopularViewModel>()
                                    .searchMovie(text);
                                break;
                              default:
                            }
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search movies...",
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.white,
                        ),
                        splashRadius: 25,
                      ),
                    ),
                  ],
                ),
              ),
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
