import 'package:flutter/material.dart';
import 'package:loginout/hotel_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:loginout/constants.dart';
import 'package:loginout/widgets/hotel_card.dart';
import 'package:loginout/widgets/hotel_card_shimmer.dart';


class RecommendedHotels extends StatelessWidget {
  const RecommendedHotels({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('hotels')
          .where('category', isEqualTo: 'recommended')
          .snapshots(),
      builder: (context, snapshot) {

        // State 1 — Shimmer while loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: List.generate(
                3, 
                (_) => const HotelCardShimmer(),
                ),
            ),
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: hotels.map((doc){
              final hotel = doc.data() as Map<String, dynamic>;
              return HotelCard(
                image: hotel['image'] ?? '', 
                hotelname: hotel['name'] ?? '', 
                location: hotel['location'] ?? '', 
                price: hotel['price'] ?? 0, 
                rating: hotel['rating'] ?? '0', 
                onTap: (){
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => HotelDetailsPage(
                        image: hotel['image'] ?? '', 
                        hotelname: hotel['name'] ?? '', 
                        location: hotel['location'] ?? '', 
                        price: hotel['price'].toString(),
                        rating: hotel['rating'] ?? '0'
                        ),
                        ),
                        );
                },
              );
                }).toList(),
          ),
        );
            },
    );
  }
}

