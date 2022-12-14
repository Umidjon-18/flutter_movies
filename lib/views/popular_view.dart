import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/popular_view_model.dart';
import '../widgets/popular_movie_grid.dart';
import 'connection_error_view.dart';

class PopularView extends StatefulWidget {
  const PopularView({Key? key}) : super(key: key);

  @override
  State<PopularView> createState() => _PopularViewState();
}

class _PopularViewState extends State<PopularView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PopularViewModel>(
      builder: (context, popularViewModel, child) {
        switch (popularViewModel.state) {
          case PopularState.init:
            Future.delayed(Duration.zero, () {
              popularViewModel.uploadMovies();
              popularViewModel.update();
            });
            return const Center(child: CupertinoActivityIndicator(
                    radius: 50,
                    color: Color.fromARGB(255, 2, 5, 82),
                  ),);
          case PopularState.loading:
            return const Center(child: CupertinoActivityIndicator(
                    radius: 50,
                    color: Color.fromARGB(255, 2, 5, 82),
                  ),);
          case PopularState.done:
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopularGrid(
                  moviesList: popularViewModel.moviesList,
                  popularViewModel: popularViewModel,
                ),
              ),
            );
          case PopularState.error:
            return const ConnectionErrorView(
              pageIndex: 2,
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
