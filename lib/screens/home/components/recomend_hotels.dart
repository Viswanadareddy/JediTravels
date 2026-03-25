import 'package:flutter/material.dart';
import 'package:loginout/config/app_config.dart';
import 'package:loginout/screens/home/components/recommended_hotels_backend.dart';
import 'package:loginout/screens/home/components/recommended_hotels_firestore.dart';

// OLD: Firestore StreamBuilder version moved to recomend_hotels_firestore.dart
// NEW: Backend FutureBuilder version in recomend_hotels_backend.dart
class RecommendedHotels extends StatelessWidget {
 const  RecommendedHotels({super.key});

  @override
  Widget build(BuildContext context) {
    //In Between Version
    if (AppConfig.useBackendHotels) {
      return RecommendedHotelsBackend();
    } else {
      return const RecommendedHotelsFirestore();
    }
  }
}
