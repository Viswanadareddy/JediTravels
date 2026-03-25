class Hotel {
  final int id;
  final String name;
  final String city;
  final String description;
  final double pricePerNight;
  final double rating;
  final String imageUrl;
  final bool isPopular;
  final bool isRecommended;

  Hotel({
    required this.id,
    required this.name,
    required this.city,
    required this.description,
    required this.pricePerNight,
    required this.rating,
    required this.imageUrl,
    required this.isPopular,
    required this.isRecommended,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      description: json['description'] ?? '',
      pricePerNight: (json['price_per_night'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      imageUrl: json['image_url'] ?? '',
      isPopular: json['is_popular'] ?? false,
      isRecommended: json['is_recommended'] ?? false,
    );
  }
}