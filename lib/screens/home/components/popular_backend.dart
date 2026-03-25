import 'package:flutter/material.dart';
import 'package:loginout/hotel_details.dart';
import 'package:loginout/models/hotel.dart';
import 'package:loginout/repositories/hotel_repository.dart';
import 'package:loginout/widgets/hotel_card.dart';
import 'package:loginout/widgets/hotel_card_shimmer.dart';

class PopularBackend extends StatelessWidget {
  PopularBackend({super.key});

  final HotelRepository _hotelRepository = HotelRepository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Hotel>>(
      future: _hotelRepository.fetchHotels(),
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

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox(
            height: 200,
            child: Center(child: Text('No hotels found')),
          );
        }

        final popularHotels =
            snapshot.data!.where((hotel) => hotel.isPopular).toList();

        if (popularHotels.isEmpty) {
          return const SizedBox(
            height: 200,
            child: Center(child: Text('No popular hotels found')),
          );
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: popularHotels.map((hotel) {
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