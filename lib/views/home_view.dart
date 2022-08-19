import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<HomeViewModel>(
      builder: (BuildContext context, homeViewModel, Widget? child) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            if (orientation == Orientation.landscape) {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                  overlays: []);
            } else {
              SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                  overlays: SystemUiOverlay.values);
            }
            return Scaffold(
              appBar: (orientation == Orientation.portrait)
                  ? AppBar(
                      centerTitle: true,
                      leading: AnimatedIconButton(
                        onPressed: () {
                          homeViewModel.isDark = !homeViewModel.isDark;
                        },
                        animationDirection: const AnimationDirection.forward(),
                        duration: const Duration(milliseconds: 700),
                        icons: [
                          AnimatedIconItem(
                            icon: homeViewModel.isDark
                                ? const Icon(
                                    Icons.sunny,
                                    color: Colors.yellow,
                                  )
                                : const Icon(
                                    Icons.nights_stay,
                                    color: Colors.black,
                                  ),
                          ),
                          AnimatedIconItem(
                            icon: homeViewModel.isDark
                                ? const Icon(
                                    Icons.sunny,
                                    color: Colors.yellow,
                                  )
                                : const Icon(
                                    Icons.nights_stay,
                                    color: Colors.black,
                                  ),
                          ),
                        ],
                      ),
                      title: Text(
                        'appName',
                        style: TextStyle(
                          fontSize: 25,
                          color: homeViewModel.isDark
                              ? Colors.blue[400]
                              : Colors.white,
                        ),
                      ).tr(),
                      actions: [
                        PopupMenuButton(
                          icon: Icon(
                            CupertinoIcons.globe,
                            color: homeViewModel.isDark
                                ? Colors.blue
                                : Colors.white,
                          ),
                          iconSize: 25,
                          // Callback that sets the selected popup menu item.
                          onSelected: (item) {},
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry>[
                            PopupMenuItem(
                              value: "english",
                              child: const Text('english').tr(),
                              onTap: () {
                                context.setLocale(const Locale('en', 'US'));
                                homeViewModel.updatePage();
                              },
                            ),
                            PopupMenuItem(
                              value: "russian",
                              child: const Text('russian').tr(),
                              onTap: () {
                                context.setLocale(const Locale('ru', 'RU'));
                                homeViewModel.updatePage();
                              },
                            ),
                            PopupMenuItem(
                              value: "uzbek",
                              child: const Text('uzbek').tr(),
                              onTap: () {
                                context.setLocale(const Locale('uz', 'UZ'));
                                homeViewModel.updatePage();
                              },
                            ),
                          ],
                        ),
                        PopupMenuButton(
                          icon: Icon(
                            Icons.sort,
                            color: homeViewModel.isDark
                                ? Colors.blue
                                : Colors.white,
                          ),
                          iconSize: 30,
                          // Callback that sets the selected popup menu item.
                          onSelected: (item) {},
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry>[
                            PopupMenuItem(
                              value: "popularity",
                              child: const Text('sortByPopularity').tr(),
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
                                myFocusNode.unfocus();
                              },
                            ),
                            PopupMenuItem(
                              value: "rate",
                              child: const Text('sortByRate').tr(),
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
                                myFocusNode.unfocus();
                              },
                            ),
                            PopupMenuItem(
                              value: "date",
                              child: const Text('sortByDate').tr(),
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
                                myFocusNode.unfocus();
                              },
                            ),
                            PopupMenuItem(
                              value: "vote",
                              child: const Text('sortByVote').tr(),
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
                                myFocusNode.unfocus();
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
                                  padding: EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    top: size.height * 0.018,
                                  ),
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
                                    focusNode: myFocusNode,
                                    autofocus: false,
                                    controller: homeViewModel.searchController,
                                    onChanged: (String text) {
                                      switch (
                                          homeViewModel.bottomSelectedIndex) {
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
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "searchHint".tr(),
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.search,
                                    size: 30,
                                    color: homeViewModel.isDark
                                        ? Colors.blue
                                        : Colors.white,
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
              body: (orientation == Orientation.portrait)
                  ? homeViewModel.buildPageView()
                  : Row(
                      children: <Widget>[
                        // #sort and search
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(top: size.height * 0.06),
                            child: Column(
                              children: [
                                PopupMenuButton(
                                  icon: const Icon(CupertinoIcons.globe,
                                      color: Colors.blue),
                                  iconSize: 25,
                                  // Callback that sets the selected popup menu item.
                                  onSelected: (item) {},
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry>[
                                    PopupMenuItem(
                                      value: "english",
                                      child: const Text('english').tr(),
                                      onTap: () {
                                        context.setLocale(
                                            const Locale('en', 'US'));
                                        homeViewModel.updatePage();
                                      },
                                    ),
                                    PopupMenuItem(
                                      value: "russian",
                                      child: const Text('russian').tr(),
                                      onTap: () {
                                        context.setLocale(
                                            const Locale('ru', 'RU'));
                                        homeViewModel.updatePage();
                                      },
                                    ),
                                    PopupMenuItem(
                                      value: "uzbek",
                                      child: const Text('uzbek').tr(),
                                      onTap: () {
                                        context.setLocale(
                                            const Locale('uz', 'UZ'));
                                        homeViewModel.updatePage();
                                      },
                                    ),
                                  ],
                                ),
                                PopupMenuButton(
                                  icon: const Icon(
                                    Icons.sort,
                                    color: Colors.blue,
                                  ),
                                  iconSize: 30,
                                  // Callback that sets the selected popup menu item.
                                  onSelected: (item) {},
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry>[
                                    PopupMenuItem(
                                      value: "popularity",
                                      child:
                                          const Text('sortByPopularity').tr(),
                                      onTap: () {
                                        switch (
                                            homeViewModel.bottomSelectedIndex) {
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
                                        myFocusNode.unfocus();
                                      },
                                    ),
                                    PopupMenuItem(
                                      value: "rate",
                                      child: const Text('sortByRate').tr(),
                                      onTap: () {
                                        switch (
                                            homeViewModel.bottomSelectedIndex) {
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
                                        myFocusNode.unfocus();
                                      },
                                    ),
                                    PopupMenuItem(
                                      value: "date",
                                      child: const Text('sortByDate').tr(),
                                      onTap: () {
                                        switch (
                                            homeViewModel.bottomSelectedIndex) {
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
                                        myFocusNode.unfocus();
                                      },
                                    ),
                                    PopupMenuItem(
                                      value: "vote",
                                      child: const Text('sortByVote').tr(),
                                      onTap: () {
                                        switch (
                                            homeViewModel.bottomSelectedIndex) {
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
                                        myFocusNode.unfocus();
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

                        // This is the main content.
                        Expanded(
                          flex: 16,
                          child: Column(
                            children: [
                              AnimatedContainer(
                                width: double.infinity,
                                height: homeViewModel
                                        .searchFieldVisibilityInOrientation
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                            margin:
                                                const EdgeInsets.only(top: 10),
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
                                              focusNode: myFocusNode,
                                              autofocus: false,
                                              controller: homeViewModel
                                                  .searchController,
                                              onChanged: (String text) {
                                                switch (homeViewModel
                                                    .bottomSelectedIndex) {
                                                  case 0:
                                                    context
                                                        .read<
                                                            NowPlayingViewModel>()
                                                        .searchMovie(text);
                                                    break;
                                                  case 1:
                                                    context
                                                        .read<
                                                            UpcomingViewModel>()
                                                        .searchMovie(text);
                                                    break;
                                                  case 2:
                                                    context
                                                        .read<
                                                            PopularViewModel>()
                                                        .searchMovie(text);
                                                    break;
                                                  default:
                                                }
                                              },
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "searchHint".tr(),
                                              ),
                                            ),
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
                        // #navigation rail
                        NavigationRail(
                          selectedIndex: homeViewModel.bottomSelectedIndex,
                          onDestinationSelected: (int index) {
                            homeViewModel.bottomTapped(index);
                          },
                          leading: SizedBox(
                            height: size.height * 0.2,
                            child: AnimatedIconButton(
                              onPressed: () {
                                homeViewModel.isDark = !homeViewModel.isDark;
                              },
                              duration: const Duration(milliseconds: 700),
                              icons: [
                                AnimatedIconItem(
                                  icon: homeViewModel.isDark
                                      ? const Icon(
                                          Icons.sunny,
                                          color: Colors.yellow,
                                        )
                                      : const Icon(
                                          Icons.nights_stay,
                                          color: Colors.black,
                                        ),
                                ),
                                AnimatedIconItem(
                                  icon: homeViewModel.isDark
                                      ? const Icon(
                                          Icons.sunny,
                                          color: Colors.yellow,
                                        )
                                      : const Icon(
                                          Icons.nights_stay,
                                          color: Colors.black,
                                        ),
                                ),
                              ],
                            ),
                          ),
                          labelType: NavigationRailLabelType.selected,
                          destinations: <NavigationRailDestination>[
                            NavigationRailDestination(
                              icon: const Icon(Icons.chair_rounded),
                              selectedIcon: const Icon(Icons.chair_rounded),
                              label: const Text('nowPlaying').tr(),
                            ),
                            NavigationRailDestination(
                              icon: const Icon(Icons.calendar_today),
                              selectedIcon: const Icon(Icons.calendar_today),
                              label: const Text('upcoming').tr(),
                            ),
                            NavigationRailDestination(
                              icon: const Icon(Icons.favorite),
                              selectedIcon: const Icon(Icons.favorite),
                              label: const Text('popular').tr(),
                            ),
                          ],
                          trailing: Expanded(child: Container()),
                        ),
                        const VerticalDivider(thickness: 1, width: 1),
                      ],
                    ),
              bottomNavigationBar: (orientation == Orientation.portrait)
                  ? BottomNavigationBar(
                      selectedItemColor: Colors.blue,
                      currentIndex: homeViewModel.bottomSelectedIndex,
                      onTap: (index) {
                        homeViewModel.bottomTapped(index);
                      },
                      items: [
                        BottomNavigationBarItem(
                          icon: const Icon(Icons.chair_rounded),
                          label: 'nowPlaying'.tr(),
                        ),
                        BottomNavigationBarItem(
                          icon: const Icon(Icons.calendar_today),
                          label: 'upcoming'.tr(),
                        ),
                        BottomNavigationBarItem(
                          icon: const Icon(Icons.favorite),
                          label: 'popular'.tr(),
                        ),
                      ],
                    )
                  : null,
            );
          },
        );
      },
    );
  }
}
