import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginout/constants.dart';

class HeaderWithSearchBox extends StatelessWidget {
  const HeaderWithSearchBox({Key? key, required this.size}) : super(key: key);

  final Size size;

  Future<String> _getUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return 'there';
    if (user.displayName != null && user.displayName!.isNotEmpty) {
      return user.displayName!;
    }
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return doc.data()?['name'] ?? 'there';
    } catch (e) {
      return 'there';
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning 👋';
    if (hour < 17) return 'Good afternoon 👋';
    return 'Good evening 👋';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
final colorScheme = Theme.of(context).colorScheme;
final searchBg = isDark ? const Color(0xFF1C2535) : Colors.white;
final hintColor = colorScheme.onSurface.withOpacity(0.65);
final inputTextColor = colorScheme.onSurface;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Constants.deepNavy,
            Constants.oceanBlue,
          ],
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
              // Top row — greeting + avatar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getGreeting(),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.75),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 2),
                      FutureBuilder<String>(
                        future: _getUserName(),
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.data ?? 'Welcome!',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  // Avatar circle
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Constants.emerald,
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/avatar.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Search bar
              Container(
                decoration: BoxDecoration(
                  color: searchBg,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  readOnly: true,
                  onTap: (){
                    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Search page coming soon')),
  );
                  },
                  style: TextStyle(color: inputTextColor),
                  decoration: InputDecoration(
                    hintText: 'Search destination...',
                    hintStyle: TextStyle(
                      color: hintColor,
                      fontSize: 14,
                    ),
                    prefixIcon:  Icon(
                      Icons.search,
                      color: isDark ? Colors.white70 : Constants.oceanBlue,
                    ),
                    suffixIcon: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Constants.emerald,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.tune,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 4,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}