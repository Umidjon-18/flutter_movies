import 'package:flutter/material.dart';
import 'package:fluttery_filmy/view_models/detail_view_model.dart';
import 'package:fluttery_filmy/views/connection_error_view.dart';
import 'package:provider/provider.dart';

import '../widgets/movie_detail_header.dart';
import '../widgets/product_com_scroller.dart';
import '../widgets/story_line.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({required this.movieId, Key? key}) : super(key: key);
  final String movieId;
  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  late DetailViewModel globalDetailViewModel;
  @override
  void dispose() {
    globalDetailViewModel.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailViewModel>(
      builder: (context, detailViewModel, child) {
        globalDetailViewModel = detailViewModel;
        switch (detailViewModel.state) {
          case DetailState.init:
            Future.delayed(Duration.zero, () {
              detailViewModel.uploadMovieDetails(widget.movieId);
              detailViewModel.update();
            });
            return Container(
              color: Colors.white,
              child: const Center(child: CircularProgressIndicator()));
          case DetailState.loading:
            return Container(
              color: Colors.white,
              child: const Center(child: CircularProgressIndicator()));
          case DetailState.done:
            return Scaffold(
              body: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MovieDetailHeader(detailViewModel.detail),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: StoryLine(detailViewModel.detail.overview ??
                            "There is no any overview about this movie"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          bottom: 50.0,
                        ),
                        child: Container(
                          color: Colors.blue,
                          // child: ProductionCompaniesScroller(
                          //     detailViewModel.detail.productionCompanies!),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          case DetailState.error:
            return ConnectionErrorView(pageIndex: 3, movieId: widget.movieId,);
          default:
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
