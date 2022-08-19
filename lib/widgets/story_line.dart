import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class StoryLine extends StatelessWidget {
  const StoryLine(this.storyline, {Key? key}) : super(key: key);

  final String storyline;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 16.0),
          child: Text(
            'overview',
            style: textTheme.headlineMedium!.copyWith(fontSize: 18.0),
          ).tr(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child: Text(
            storyline,
            style: textTheme.bodyText1!
                .copyWith(color: Colors.grey, fontSize: 16.0),
          ),
        ),
        // No expand-collapse in this tutorial, we just slap the "more"
        // button below the text like in the mockup.
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'more',
                style: textTheme.bodyText1!
                    .copyWith(fontSize: 16.0, color: theme.colorScheme.primary),
              ).tr(),
              Icon(
                Icons.keyboard_arrow_down,
                size: 18.0,
                color: theme.colorScheme.primary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
