import 'package:flutter/material.dart';
import 'package:loginout/constants.dart';
class HotelCard extends StatelessWidget{
  const HotelCard({
    super.key,
    required this.image,
    required this.hotelname,
    required this.location,
    required this.price,
    required this.rating,
    required this.onTap,
  });

  final String image;
  final String hotelname;
  final String location;
  final int price;
  final String rating;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context)
  {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: hotelname,
        child: Container(
          width: 280,
          height: 200,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(
                  isDark ? 0.28 : 0.15),
                blurRadius: 12,
                offset: const Offset(0,4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children:[
                //Layer 1-full bleed image
                Positioned.fill(
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                  ),
                 // Layer 2- gardient overlay
                 Positioned(
                  child:DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        stops: const [0.4,1.0],
                        ),
                    ),
                    ), 
                  ),

                  // Layer 3 - rating badge top right
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFFF4F6F9) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min ,
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 14,
                            color:  Color(0xFFFFC107),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              rating,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              ),
                        ],
                        ),
                    ),
                    ),

                    // Layer 4- hotel info bottom left
                    Positioned(
                      left: 12,
                      bottom: 12,
                      right: 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            hotelname,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 12,
                                  color: Colors.white70),
                                  const SizedBox(width: 2),
                                  Text(
                                    location,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                    ),
                              ],
                            ),
                        ],
                      ),
                    ),

                    // Layer 5 -price badge bottom right
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Constants.emerald,

                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '\$$price',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          ),
                      ),
                      ), 
              ],
            ),
          ),
        ),
        ),
    );
  }  
}