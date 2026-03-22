import 'package:flutter/material.dart';
import 'package:loginout/hotel_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loginout/constants.dart';

class RecommendedHotels extends StatelessWidget {
  const RecommendedHotels({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('hotels')
          .where('category', isEqualTo: 'recommended')
          .snapshots(),
      builder: (context, snapshot) {

        // State 1 — still loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        // State 2 — error occurred
        if (snapshot.hasError) {
          return const SizedBox(
            height: 200,
            child: Center(child: Text('Could not load hotels')),
          );
        }

        // State 3 — no data
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const SizedBox(
            height: 200,
            child: Center(child: Text('No hotels available')),
          );
        }

        // State 4 — data arrived, build the list
        final hotels = snapshot.data!.docs;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              hotels.length,
              (index) {
                final hotel = hotels[index].data() as Map<String, dynamic>;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HotelDetailsPage(
                          image: hotel['image'] ?? '',
                          hotelname: hotel['name'] ?? '',
                          location: hotel['location'] ?? '',
                          price: hotel['price'].toString(),
                          rating: hotel['rating'] ?? '0',
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 20,
                      left: index == 0 ? 20 : 0,
                    ),
                    child: RecommendedHotelCard(
                      image: hotel['image'] ?? '',
                      hotelname: hotel['name'] ?? '',
                      location: hotel['location'] ?? '',
                      price: hotel['price'] ?? 0,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class RecommendedHotelCard extends StatelessWidget {
  const RecommendedHotelCard({
    Key? key,
    required this.image,
    required this.hotelname,
    required this.location,
    required this.price,
  }) : super(key: key);

  final String image, hotelname, location;
  final int price;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.6,
      child: Column(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(image)),
          Container(
            padding: EdgeInsets.all(Constants.kDefaultPadding / 2),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "$hotelname\n".toUpperCase(),
                          style: Theme.of(context).textTheme.labelLarge),
                      TextSpan(
                        text: "$location".toUpperCase(),
                        style: const TextStyle(
                          color: Constants.kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  '\$$price',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Constants.kPrimaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

