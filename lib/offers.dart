import 'package:flutter/material.dart';
import 'package:loginout/constants.dart';

class Offers extends StatelessWidget {
  const Offers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Constants.deepNavy, Constants.oceanBlue],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hot Deals 🔥',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Limited time offers — grab them before they\'re gone',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Offer cards
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                OfferCard(
                  title: 'First Booking Deal',
                  subtitle: '70% off on your first booking',
                  code: 'FIRSTONE',
                  discount: '70% OFF',
                  imagePath: 'assets/offers/offer1.jpeg',
                  discountColor: Color(0xFFE53935),
                ),
                SizedBox(height: 14),
                OfferCard(
                  title: 'UPI Cashback',
                  subtitle: '25% cashback on any UPI payment',
                  code: 'UPICASH25',
                  discount: '25% BACK',
                  imagePath: 'assets/offers/offer2.jpeg',
                  discountColor: Color(0xFF7B1FA2),
                ),
                SizedBox(height: 14),
                OfferCard(
                  title: 'Jedi Special',
                  subtitle: '30% discount on selected rooms',
                  code: 'JEDI',
                  discount: '30% OFF',
                  imagePath: 'assets/offers/offer3.jpeg',
                  discountColor: Color(0xFF00838F),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OfferCard extends StatelessWidget {
  const OfferCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.code,
    required this.discount,
    required this.imagePath,
    required this.discountColor,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String code;
  final String discount;
  final String imagePath;
  final Color discountColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
final isDark = Theme.of(context).brightness == Brightness.dark;
final secondaryText = colorScheme.onSurface.withOpacity(0.7);
final cardColor = isDark ? const Color(0xFF1C2535) : Constants.cardWhite;
final chipBg = isDark ? Colors.white12 : Constants.deepNavy.withOpacity(0.08);
final chipBorder = isDark ? Colors.white24 : Constants.deepNavy.withOpacity(0.2);
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Image section
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Stack(
              children: [
                Image.asset(
                  imagePath,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stack) => Container(
                    height: 140,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          discountColor.withOpacity(0.7),
                          Constants.deepNavy,
                        ],
                      ),
                    ),
                  ),
                ),
                // Discount badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: discountColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      discount,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Info section
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style:  TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: secondaryText,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Code chip
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: chipBg,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: chipBorder,
                          ),
                        ),
                        child: Text(
                          'Code: $code',
                          style:  TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Claim button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.emerald,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Claim',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}