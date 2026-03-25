import 'package:flutter/material.dart';
import 'package:loginout/config/app_config.dart';
import 'package:loginout/screens/home/components/popular_backend.dart';
import 'package:loginout/screens/home/components/popular_firestore.dart';

class Popular extends StatelessWidget {
  const Popular({super.key});

  @override
  Widget build(BuildContext context) {
    if (AppConfig.useBackendHotels) {
      return PopularBackend();
    } else {
      return const PopularFirestore();
    }
  }
}