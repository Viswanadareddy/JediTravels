//Working need to change a bit
import 'package:flutter/material.dart';
import 'package:loginout/constants.dart';
import 'package:loginout/payments.dart';

class HotelDetailsPage extends StatelessWidget {
   HotelDetailsPage({
    Key? key,
    this.hotelId,
    required this.image,
    required this.hotelname,
    required this.location,
    required this.price,
    required this.rating,
  }) : super(key: key);
  final int? hotelId;
  final String image;
  final String hotelname;
  final String location;
  final String price;
  final String rating;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
final isDark = Theme.of(context).brightness == Brightness.dark;
final secondaryText = colorScheme.onSurface.withOpacity(0.78);
final detailsCardColor = isDark ? const Color(0xFF1E2A3D) : Colors.white;
final tagColor = isDark ? Colors.white12 : Colors.grey.shade300;
    return Scaffold(
      backgroundColor :isDark ? const Color(0xFF0B1220) :colorScheme.surface,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 400,
                  child: Hero(
                    tag: hotelname,
                    child: Image.asset('$image', fit: BoxFit.cover),
                ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "$hotelname",
                    style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: <Widget>[
                    const SizedBox(width: 16.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      decoration: BoxDecoration(
                          color: tagColor,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Text(
                        "Top Rated",
                        style: TextStyle(color: colorScheme.onSurface, fontSize: 13.0),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      color: Constants.emerald,
                      icon: Icon(Icons.favorite_border),
                      onPressed: () {},
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(32.0),
                  color: detailsCardColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "$rating",
                                      style: TextStyle(
                                        color: colorScheme.onSurface,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      ),
                                    Icon(
                                      Icons.star,
                                      color: const Color(0xFFFFC107),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: const Color(0xFFFFC107),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: const Color(0xFFFFC107),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: const Color(0xFFFFC107),
                                    ),
                                    Icon(
                                      Icons.star_border,
                                      color: const Color(0xFFFFC107),
                                    ),
                                  ],
                                ),
                                Text.rich(
                                  TextSpan(children: [
                                    WidgetSpan(
                                        child: Icon(
                                      Icons.location_on,
                                      size: 16.0,
                                      color: secondaryText,
                                    )),
                                    TextSpan(text: "$location")
                                  ]),
                                  style: TextStyle(
                                      color: secondaryText, fontSize: 12.0),
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                "\$ $price",
                                style: TextStyle(
                                    color: colorScheme.onSurface,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              Text(
                                "/per night",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Constants.emerald),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Amenities",
                          style: TextStyle(
                            fontSize: 18,
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.sports_esports,
                              color: colorScheme.onSurface),
                              Text("Sports",
                              style: TextStyle(color: colorScheme.onSurface),),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.local_parking,
                              color: colorScheme.onSurface,
                              ),
                              Text("Parking",
                              style: TextStyle(color: colorScheme.onSurface),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.local_bar,
                              color: colorScheme.onSurface),
                              Text("Bar",
                              style: TextStyle(color: colorScheme.onSurface),),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.wifi, 
                              color: colorScheme.onSurface,),
                              Text("Wifi",
                              style: TextStyle(color: colorScheme.onSurface),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          color: Constants.deepNavy,
                          textColor: Colors.white,
                          child: Text(
                            "Book Now",
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 32.0,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PaymentsPage(
                                        hotelId: hotelId,
                                          price: price,
                                          hotelname: hotelname,
                                        )));
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Text(
                        "Description".toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600, 
                            fontSize: 14.0,
                            color: colorScheme.onSurface),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        "$hotelname is a mixture of sophisticated and relaxed ambience offering a big range of quality services and a modern design & decoration. .The contemporary design of the 167 Deluxe Rooms and 4 Suites combines elegance and sobriety. All rooms are complemented with luxury linens and bathrobe and come equipped with hairdryer, telephone with 2 lines, air conditioning, satellite TV, Pay TV, WiFi Internet access, minibar and safe-deposit box. Our Ad Lib Restaurant, 24 hour Room Service, Business Centre and Fitness Centre, Intra-Muros Bar, Cigar Lounge and Lobby Library are waiting for you.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 14.0, color: secondaryText),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: true,
              elevation: 0,
               iconTheme: const IconThemeData(color: Colors.white),
            ),
          ),
          /*Align(
            alignment: Alignment.bottomLeft,
            child: BottomNavigationBar(
              backgroundColor: Colors.white54,
              elevation: 0,
              selectedItemColor: Colors.black,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), title: Text("Search")),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border),
                    title: Text("Favorites")),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), title: Text("Settings")),
              ],
            ),
          )*/
        ],
      ),
    );
  }
}
