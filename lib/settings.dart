import 'package:flutter/material.dart';
import 'package:loginout/constants.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
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
                child: const Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Settings groups
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                // Preferences section
                _sectionLabel('Preferences'),
                const SizedBox(height: 8),
                _settingsCard([
                  _toggleItem(
                    icon: Icons.notifications_outlined,
                    iconColor: const Color(0xFF4CAF50),
                    label: 'Push Notifications',
                    subtitle: 'Booking alerts and offers',
                    value: _notificationsEnabled,
                    onChanged: (val) =>
                        setState(() => _notificationsEnabled = val),
                  ),
                ]),

                const SizedBox(height: 20),

                // App section
                _sectionLabel('App'),
                const SizedBox(height: 8),
                _settingsCard([
                  _navItem(
                    icon: Icons.info_outline,
                    iconColor: const Color(0xFF1976D2),
                    label: 'About JediTravels',
                    onTap: () => Navigator.pushNamed(context, 'about'),
                  ),
                  _divider(),
                  _navItem(
                    icon: Icons.shield_outlined,
                    iconColor: const Color(0xFF7B1FA2),
                    label: 'Terms & Conditions',
                    onTap: () =>
                        Navigator.pushNamed(context, 'terms_and_conditions'),
                  ),
                  _divider(),
                  _navItem(
                    icon: Icons.star_outline,
                    iconColor: const Color(0xFFFF8F00),
                    label: 'Rate the App',
                    onTap: () {},
                  ),
                  _divider(),
                  _navItem(
                    icon: Icons.share_outlined,
                    iconColor: const Color(0xFF0097A7),
                    label: 'Share JediTravels',
                    onTap: () {},
                  ),
                ]),

                const SizedBox(height: 20),

                // Version
                Center(
                  child: Text(
                    'JediTravels v1.0.0',
                    style: TextStyle(
                      fontSize: 12,
                      color: Constants.mutedText,
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

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _settingsCard(List<Widget> children) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
final cardColor = isDark ? const Color(0xFF1C2535) : Constants.cardWhite;
    return Container(
      decoration: BoxDecoration(
        color:  cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _divider() {
    return Divider(
      height: 1,
      indent: 56,
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.12),
    );
  }

  Widget _toggleItem({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
final secondaryText = colorScheme.onSurface.withOpacity(0.7);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style:  TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: secondaryText,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Constants.emerald,
          ),
        ],
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required Color iconColor,
    required String label,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
final secondaryText = colorScheme.onSurface.withOpacity(0.7);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style:  TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
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