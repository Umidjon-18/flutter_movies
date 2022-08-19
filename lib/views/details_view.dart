import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttery_filmy/view_models/detail_view_model.dart';
import 'package:fluttery_filmy/views/connection_error_view.dart';
import 'package:fluttery_filmy/widgets/additional_details.dart';
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
    var theme = Theme.of(context);
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
                color: theme.colorScheme.background,
                child: const Center(child: CupertinoActivityIndicator(
                    radius: 50,
                    color: Color.fromARGB(255, 2, 5, 82),
                  ),));
          case DetailState.loading:
            return Container(
                color: theme.colorScheme.background,
                child: const Center(child: CupertinoActivityIndicator(
                    radius: 50,
                    color: Color.fromARGB(255, 2, 5, 82),
                  ),));
          case DetailState.done:
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    MovieDetailHeader(detailViewModel.detail),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: StoryLine(detailViewModel.detail.overview ??
                          "defaultOverview".tr()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        bottom: 10.0,
                      ),
                      child: ProductionCompaniesScroller(
                          detailViewModel.detail.productionCompanies!),
                    ),
                    AdditionalDetails(detailViewModel.detail),
                  ],
                ),
              ),
            );
          case DetailState.error:
            return ConnectionErrorView(
              pageIndex: 3,
              movieId: widget.movieId,
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
