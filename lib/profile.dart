import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginout/start.dart';
import 'constants.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<DocumentSnapshot> getUserData(String uid) async {
    var data = await _firestore.collection('users').doc(uid).get();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme= Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Constants.deepNavy,
        automaticallyImplyLeading: false,
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: getUserData(user!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('Could not load profile'));
          }
          return _buildProfile(
            snapshot.data!['name'] ?? 'User',
            snapshot.data!['email'] ?? '',
          );
        },
      ),
    );
  }

  Widget _buildProfile(String name, String email) {
    final colorScheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header section with avatar
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Constants.deepNavy,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 24),
                // Avatar
                Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Constants.emerald,
                          width: 3,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/avatar.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: Constants.emerald,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Name
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                // Email
                Text(
                  email,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 28),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Info cards
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // My Bookings button
                
                _menuItem(
                  icon: Icons.history,
                  label: 'My Bookings',
                  onTap: () => Navigator.pushNamed(context, 'booking_history'),
                ),
                const SizedBox(height: 12),
                _menuItem(
                  icon: Icons.person_outline,
                  label: 'Edit Profile',
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _menuItem(
                  icon: Icons.notifications_outlined,
                  label: 'Notifications',
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _menuItem(
                  icon: Icons.help_outline,
                  label: 'Help & Support',
                  onTap: () {},
                ),

                const SizedBox(height: 32),

                // Logout button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await _auth.signOut();
                      if (mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StartPage(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: const Text(
                      'Log Out',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade400,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
final isDark = Theme.of(context).brightness == Brightness.dark;
final cardColor = isDark ? const Color(0xFF1C2535) : Constants.cardWhite;
final iconBg = isDark ? Colors.white12 : Constants.deepNavy.withOpacity(0.08);
final iconColor = isDark ? Colors.white : Constants.deepNavy;
final secondaryText = colorScheme.onSurface.withOpacity(0.7);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Text(
              label,
              style:  TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurface,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: secondaryText,
            ),
          ],
        ),
      ),
    );
  }
}