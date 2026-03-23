import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginout/constants.dart';
import 'package:loginout/hotel_details.dart';

class ShowAllPage extends StatelessWidget {
  final String title;
  final String category;

  const ShowAllPage({
    Key? key,
    required this.title,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Constants.deepNavy,
        foregroundColor: Colors.white,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('hotels')
            .where('category', isEqualTo: category)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Could not load hotels'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No hotels found'),
            );
          }

          final hotels = snapshot.data!.docs;

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: hotels.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1.28,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              final hotel = hotels[index].data() as Map<String, dynamic>;

              return _ShowAllHotelCard(
                image: hotel['image'] ?? '',
                hotelname: hotel['name'] ?? '',
                location: hotel['location'] ?? '',
                price: hotel['price'].toString(),
                rating: hotel['rating']?.toString() ?? '0',
                isDark: isDark,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HotelDetailsPage(
                        image: hotel['image'] ?? '',
                        hotelname: hotel['name'] ?? '',
                        location: hotel['location'] ?? '',
                        price: hotel['price'].toString(),
                        rating: hotel['rating']?.toString() ?? '0',
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _ShowAllHotelCard extends StatelessWidget {
  final String image;
  final String hotelname;
  final String location;
  final String price;
  final String rating;
  final bool isDark;
  final VoidCallback onTap;

  const _ShowAllHotelCard({
    Key? key,
    required this.image,
    required this.hotelname,
    required this.location,
    required this.price,
    required this.rating,
    required this.isDark,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.28 : 0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.15),
                        Colors.black.withOpacity(0.72),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 14,
                right: 14,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFFF4F6F9) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        rating,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Constants.deepNavy,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 18,
                right: 18,
                bottom: 18,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hotelname,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.white70,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  location,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Constants.emerald,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '\$$price',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}