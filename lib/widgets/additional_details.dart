import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttery_filmy/models/detail_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AdditionalDetails extends StatelessWidget {
  const AdditionalDetails(this.movie, {Key? key}) : super(key: key);

  final DetailModel movie;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    var textTheme = Theme.of(context).textTheme;
    List spokenLanguages = List.generate(movie.spokenLanguages!.length,
        ((index) => movie.spokenLanguages![index].name));
    List productionCountries = List.generate(movie.productionCountries!.length,
        ((index) => movie.productionCountries![index].name));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'additionalDetails',
            style: textTheme.headlineMedium!.copyWith(
              fontSize: 20.0,
            ),
          ).tr(),
        ),
        SizedBox.fromSize(
          size: orientation == Orientation.portrait
              ? Size.fromHeight(size.height * 0.7)
              : Size.fromHeight(size.height),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(left: 20.0),
            children: [
              ListTile(
                leading: const Icon(
                  Icons.calendar_month_rounded,
                ),
                title: Text(movie.releaseDate.toString()),
              ),
              ListTile(
                leading: const Icon(
                  Icons.favorite,
                ),
                title: Text("${movie.voteCount} ${"likes".tr()}"),
              ),
              ListTile(
                leading: const Icon(
                  Icons.hourglass_bottom_rounded,
                ),
                title: Text("${movie.runtime} ${"minutes".tr()}"),
              ),
              ListTile(
                leading: const Icon(
                  Icons.monetization_on_outlined,
                ),
                title: Text("${movie.revenue} USD"),
              ),
              ListTile(
                leading: const Icon(
                  CupertinoIcons.globe,
                ),
                title: Text(spokenLanguages.join(', ')),
              ),
              ListTile(
                leading: const Icon(
                  Icons.flag,
                ),
                title: Text(productionCountries.join(', ')),
              ),
              ListTile(
                leading: const Icon(
                  CupertinoIcons.location_solid,
                ),
                title: GestureDetector(
                  child: Text(
                      movie.homepage ?? 'https://www.google.com'.toString(),
                      style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue)),
                  onTap: () async {
                    var url = movie.homepage ?? 'https://www.google.com';
                    await launchUrlString(url);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
