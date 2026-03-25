import '../models/hotel.dart';
import '../services/api_service.dart';

class HotelRepository {
  final ApiService _apiService = ApiService();

  Future<List<Hotel>> fetchHotels() async {
    final data = await _apiService.getHotels();
    return data.map<Hotel>((item) => Hotel.fromJson(item)).toList();
  }
}