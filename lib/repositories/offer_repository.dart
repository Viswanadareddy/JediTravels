import '../models/offer.dart';
import '../services/api_service.dart';

class OfferRepository {
  final ApiService _apiService = ApiService();

  Future<List<Offer>> fetchOffers() async {
    final data = await _apiService.getOffers();
    return data.map<Offer>((item) => Offer.fromJson(item)).toList();
  }
}