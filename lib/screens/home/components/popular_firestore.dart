import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loginout/hotel_details.dart';
import 'package:loginout/widgets/hotel_card.dart';
import 'package:loginout/widgets/hotel_card_shimmer.dart';

class PopularFirestore extends StatelessWidget {
  const PopularFirestore({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('hotels')
          .where('category', isEqualTo: 'popular')
          .snapshots(),
      builder: (context, snapshot) {
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

        if (snapshot.hasError) {
          return const SizedBox(
            height: 200,
            child: Center(child: Text('Could not load hotels')),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const SizedBox(
            height: 200,
            child: Center(child: Text('No hotels found')),
          );
        }

        final hotels = snapshot.data!.docs;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: hotels.map((doc) {
              final hotel = doc.data() as Map<String, dynamic>;

              return HotelCard(
                image: hotel['image'] ?? '',
                hotelname: hotel['name'] ?? '',
                location: hotel['location'] ?? '',
                price: hotel['price'] ?? 0,
                rating: hotel['rating']?.toString() ?? '0',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HotelDetailsPage(
                        image: hotel['image'] ?? '',
                        hotelname: hotel['name'] ?? '',
                        location: hotel['location'] ?? '',
                        price: (hotel['price'] ?? 0).toString(),
                        rating: hotel['rating']?.toString() ?? '0',
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