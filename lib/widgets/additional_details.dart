import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:fluttery_filmy/models/detail_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AdditionalDetails extends StatelessWidget {
  const AdditionalDetails(this.movie, {Key? key}) : super(key: key);

  final DetailModel movie;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            'Additional Details',
            style: textTheme.headlineMedium!
                .copyWith(fontSize: 20.0, color: Colors.black),
          ),
        ),
        SizedBox.fromSize(
          size: Size.fromHeight(size.height * 0.7),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.only(left: 20.0),
            children: [
              ListTile(
                leading: Icon(
                  Icons.calendar_month_rounded,
                  color: Colors.blueGrey[900],
                ),
                title: Text(movie.releaseDate.toString()),
              ),
              ListTile(
                leading: Icon(
                  Icons.favorite,
                  color: Colors.blueGrey[900],
                ),
                title: Text("${movie.voteCount} likes"),
              ),
              ListTile(
                leading: Icon(
                  Icons.hourglass_bottom_rounded,
                  color: Colors.blueGrey[900],
                ),
                title: Text("${movie.runtime} minutes"),
              ),
              ListTile(
                leading: Icon(
                  Icons.monetization_on_outlined,
                  color: Colors.blueGrey[900],
                ),
                title: Text("${movie.revenue} USD"),
              ),
              ListTile(
                leading: Icon(
                  CupertinoIcons.globe,
                  color: Colors.blueGrey[900],
                ),
                title: Text(spokenLanguages.join(', ')),
              ),
              ListTile(
                leading: Icon(
                  MaterialIcons.flag,
                  color: Colors.blueGrey[900],
                ),
                title: Text(productionCountries.join(', ')),
              ),
              ListTile(
                leading: Icon(
                  CupertinoIcons.location_solid,
                  color: Colors.blueGrey[900],
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
