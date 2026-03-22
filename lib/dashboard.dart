import 'package:flutter/material.dart';
import 'package:loginout/constants.dart';

import 'screens/home/components/popular.dart';
import 'screens/home/components/header_with_search.dart';
import 'screens/home/components/recomend_hotels.dart';
import 'screens/home/components/show_all.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          Showall(title: "Recomended"),
          const SizedBox(height: 10),
          RecommendedHotels(),
          Showall(title: "Popular"),
          const SizedBox(height: 10),
          Popular(),
          SizedBox(height: Constants.kDefaultPadding),
        ],
      ),
    );
  }
}
