class Offer {
  final int id;
  final String code;
  final String title;
  final String description;
  final double discountPercent;
  final bool isActive;

  Offer({
    required this.id,
    required this.code,
    required this.title,
    required this.description,
    required this.discountPercent,
    required this.isActive,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      code: json['code'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      discountPercent: (json['discount_percent'] as num).toDouble(),
      isActive: json['is_active'] ?? false,
    );
  }
}