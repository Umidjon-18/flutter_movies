import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttery_filmy/view_models/upcoming_view_model.dart';
import 'package:provider/provider.dart';

import '../widgets/upcoming_movie_grid.dart';
import 'connection_error_view.dart';

class UpcomingView extends StatefulWidget {
  const UpcomingView({Key? key}) : super(key: key);

  @override
  State<UpcomingView> createState() => _UpcomingViewState();
}

class _UpcomingViewState extends State<UpcomingView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UpcomingViewModel>(
      builder: (context, upcomingViewModel, child) {
        switch (upcomingViewModel.state) {
          case UpcomingState.init:
            Future.delayed(Duration.zero, () {
              upcomingViewModel.uploadMovies();
              upcomingViewModel.update();
            });
            return const Center(child: CupertinoActivityIndicator(
                    radius: 50,
                    color: Color.fromARGB(255, 2, 5, 82),
                  ),);
          case UpcomingState.loading:
            return const Center(child: CupertinoActivityIndicator(
                    radius: 50,
                    color: Color.fromARGB(255, 2, 5, 82),
                  ),);
          case UpcomingState.done:
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: UpcomingGrid(
                  moviesList: upcomingViewModel.moviesList,
                  upcomingViewModel: upcomingViewModel,
                ),
              ),
            );
          case UpcomingState.error:
            return const ConnectionErrorView(
              pageIndex: 1,
            );
          default:
        }
        return const Center(child: CupertinoActivityIndicator(
                    radius: 50,
                    color: Color.fromARGB(255, 2, 5, 82),
                  ),);
      },
    );
  }
}
