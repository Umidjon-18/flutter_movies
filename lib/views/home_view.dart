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
          appBar: (MediaQuery.of(context).orientation == Orientation.portrait)
              ? AppBar(
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () {
                      homeViewModel.isDark = !homeViewModel.isDark;
                    },
                    icon: homeViewModel.isDark
                        ? Icon(
                            Icons.sunny,
                            color: Colors.grey[300],
                          )
                        : Icon(
                            Icons.nights_stay,
                            color: Colors.grey[800],
                          ),
                  ),
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
                            FocusScope.of(context).unfocus();
                            homeViewModel.searchController.clear();
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
                            FocusScope.of(context).unfocus();
                            homeViewModel.searchController.clear();
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
                            FocusScope.of(context).unfocus();
                            homeViewModel.searchController.clear();
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
                            FocusScope.of(context).unfocus();
                            homeViewModel.searchController.clear();
                          },
                        ),
                      ],
                    ),
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
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, top: 10),
                              decoration: BoxDecoration(
                                color: homeViewModel.isDark
                                    ? Colors.grey[800]
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 1,
                                    color: homeViewModel.isDark
                                        ? Colors.grey
                                        : Colors.white),
                              ),
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
                                  hintStyle: TextStyle(color: Colors.grey),
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
                )
              : null,
          body: (MediaQuery.of(context).orientation == Orientation.portrait)
              ? homeViewModel.buildPageView()
              : Row(
                  children: <Widget>[
                    NavigationRail(
                      selectedIndex: homeViewModel.bottomSelectedIndex,
                      onDestinationSelected: (int index) {
                        homeViewModel.bottomTapped(index);
                      },
                      leading: SizedBox(
                        height: size.height * 0.2,
                        child: IconButton(
                          onPressed: () {
                            homeViewModel.isDark = !homeViewModel.isDark;
                          },
                          icon: homeViewModel.isDark
                              ? Icon(
                                  Icons.sunny,
                                  color: Colors.grey[100],
                                )
                              : const Icon(
                                  Icons.nights_stay,
                                  color: Colors.black,
                                ),
                        ),
                      ),
                      labelType: NavigationRailLabelType.selected,
                      destinations: const <NavigationRailDestination>[
                        NavigationRailDestination(
                          icon: Icon(Icons.chair_rounded),
                          selectedIcon: Icon(Icons.chair_rounded),
                          label: Text('Now Playing'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.calendar_today),
                          selectedIcon: Icon(Icons.calendar_today),
                          label: Text('Upcoming'),
                        ),
                        NavigationRailDestination(
                          icon: Icon(Icons.favorite),
                          selectedIcon: Icon(Icons.favorite),
                          label: Text('Popular'),
                        ),
                      ],
                      trailing: Expanded(child: Container()),
                    ),
                    const VerticalDivider(thickness: 1, width: 1),
                    // This is the main content.
                    Expanded(
                      flex: 16,
                      child: Column(
                        children: [
                          AnimatedContainer(
                            width: double.infinity,
                            height:
                                homeViewModel.searchFieldVisibilityInOrientation
                                    ? 50.0
                                    : 0.0,
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeIn,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 9,
                                    child: Visibility(
                                      visible: homeViewModel
                                          .searchFieldVisibilityInOrientation,
                                      child: Container(
                                        width: double.infinity,
                                        height: 40,
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15, top: 10),
                                        margin: const EdgeInsets.only(top: 10),
                                        decoration: BoxDecoration(
                                          color: homeViewModel.isDark
                                              ? Colors.grey[800]
                                              : Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1,
                                              color: homeViewModel.isDark
                                                  ? Colors.grey
                                                  : Colors.white),
                                        ),
                                        child: TextField(
                                          autocorrect: false,
                                          autofocus: false,
                                          controller:
                                              homeViewModel.searchController,
                                          onChanged: (String text) {
                                            switch (homeViewModel
                                                .bottomSelectedIndex) {
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
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Visibility(
                                      visible: homeViewModel
                                          .searchFieldVisibilityInOrientation,
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.search,
                                          size: 40,
                                          color: Colors.blue,
                                        ),
                                        splashRadius: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: homeViewModel.buildPageView(),
                          ),
                        ],
                      ),
                    ),
                    const VerticalDivider(thickness: 1, width: 1),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(top: size.height * 0.08),
                        child: Column(
                          children: [
                            PopupMenuButton(
                              icon: const Icon(Icons.sort),
                              iconSize: 30,
                              // Callback that sets the selected popup menu item.
                              onSelected: (item) {},
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry>[
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
                                    FocusScope.of(context).unfocus();
                                    homeViewModel.searchController.clear();
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
                                        context
                                            .read<UpcomingViewModel>()
                                            .sortByRate();
                                        break;
                                      case 2:
                                        context
                                            .read<PopularViewModel>()
                                            .sortByRate();
                                        break;
                                      default:
                                    }
                                    FocusScope.of(context).unfocus();
                                    homeViewModel.searchController.clear();
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
                                        context
                                            .read<UpcomingViewModel>()
                                            .sortByDate();
                                        break;
                                      case 2:
                                        context
                                            .read<PopularViewModel>()
                                            .sortByDate();
                                        break;
                                      default:
                                    }
                                    FocusScope.of(context).unfocus();
                                    homeViewModel.searchController.clear();
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
                                        context
                                            .read<UpcomingViewModel>()
                                            .sortByVote();
                                        break;
                                      case 2:
                                        context
                                            .read<PopularViewModel>()
                                            .sortByVote();
                                        break;
                                      default:
                                    }
                                    FocusScope.of(context).unfocus();
                                    homeViewModel.searchController.clear();
                                  },
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                homeViewModel
                                        .searchFieldVisibilityInOrientation =
                                    !homeViewModel
                                        .searchFieldVisibilityInOrientation;
                                homeViewModel.updatePage();
                              },
                              icon: Icon(
                                Icons.search,
                                size: 30,
                                color: homeViewModel
                                        .searchFieldVisibilityInOrientation
                                    ? Colors.blue
                                    : homeViewModel.isDark
                                        ? Colors.white
                                        : Colors.grey[900],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
          bottomNavigationBar:
              (MediaQuery.of(context).orientation == Orientation.portrait)
                  ? BottomNavigationBar(
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
                    )
                  : null,
        );
      },
    );
  }
}
