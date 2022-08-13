import 'package:flutter/material.dart';

import '../models/detail_model.dart';

class ProductionCompaniesScroller extends StatelessWidget {
  ProductionCompaniesScroller(this.productionCompanies);

  final List<ProductionCompanies> productionCompanies;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Production Companies',
            style: textTheme.headlineMedium!.copyWith(fontSize: 18.0),
          ),
        ),
        Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.red, width: 2)),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                  border: Border.all(color: const Color(0xFF8e44ad), width: 3),
                ),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(70),
                    child: Image.network(
                      'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
                      fit: BoxFit.cover,
                      width: 70,
                      height: 70,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(productionCompanies.length.toString()),
            ],
          ),
        ),
      ],
    );
  }
}
