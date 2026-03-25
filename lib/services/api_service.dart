import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import '../config/app_config.dart';

class ApiService {
  Future<Map<String, String>> _headers() async {
    final user = FirebaseAuth.instance.currentUser;
    final token = await user?.getIdToken();

    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<Map<String, dynamic>> getPricingQuote({
  required int hotelId,
  required String checkIn,
  required String checkOut,
  required int guests,
  int offerPercent = 0,
}) async {
  final response = await http.post(
    Uri.parse('${AppConfig.baseUrl}/pricing/quote'),
    headers: await _headers(),
    body: jsonEncode({
      'hotel_id': hotelId,
      'check_in': checkIn,
      'check_out': checkOut,
      'guests': guests,
      'offer_percent': offerPercent,
    }),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body) as Map<String, dynamic>;
  } else {
    throw Exception('Failed to get pricing quote: ${response.body}');
  }
}

  Future<List<dynamic>> getHotels() async {
    final response = await http.get(
      Uri.parse('${AppConfig.baseUrl}/hotels'),
      headers: await _headers(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load hotels');
    }
  }

  Future<Map<String, dynamic>> createBooking({
    required int hotelId,
    required String checkIn,
    required String checkOut,
    required int guests,
  }) async {
    final response = await http.post(
      Uri.parse('${AppConfig.baseUrl}/bookings'),
      headers: await _headers(),
      body: jsonEncode({
        'hotel_id': hotelId,
        'check_in': checkIn,
        'check_out': checkOut,
        'guests': guests,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create booking');
    }
  }
}