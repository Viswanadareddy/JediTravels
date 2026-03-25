import 'package:flutter/material.dart';
import 'package:loginout/hotel_details.dart';
import 'package:loginout/models/hotel.dart';
import 'package:loginout/repositories/hotel_repository.dart';
import 'package:loginout/widgets/hotel_card.dart';
import 'package:loginout/widgets/hotel_card_shimmer.dart';

class RecommendedHotelsBackend extends StatelessWidget {
  RecommendedHotelsBackend({super.key});

  final HotelRepository _hotelRepository = HotelRepository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Hotel>>(
      future: _hotelRepository.fetchHotels(),
      builder: (context, snapshot) {
        // State 1 — loading
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

        // State 2 — error
        if (snapshot.hasError) {
          return  SizedBox(
            height: 200,
            child: Center(child: Text('Could not load hotels: ${snapshot.error}'),),
          );
        }

        // State 3 — empty
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox(
            height: 200,
            child: Center(child: Text('No hotels available')),
          );
        }

        // State 4 — success
        final hotels = snapshot.data!;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: hotels.map((hotel) {
              return HotelCard(
                image: hotel.imageUrl,
                hotelname: hotel.name,
                location: hotel.city,
                price: hotel.pricePerNight.toInt(),
                rating: hotel.rating.toString(),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HotelDetailsPage(
                        hotelId: hotel.id,
                        image: hotel.imageUrl,
                        hotelname: hotel.name,
                        location: hotel.city,
                        price: hotel.pricePerNight.toString(),
                        rating: hotel.rating.toString(),
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