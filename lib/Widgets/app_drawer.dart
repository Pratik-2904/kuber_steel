import 'package:flutter/material.dart';

import '../pages/contact_us_page.dart';
import '../theme/app_theme.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.cardColor,
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildDrawerHeader(),
          const Divider(),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  icon: Icons.home_outlined,
                  title: 'Home',
                  context: context,
                  onTap: () => Navigator.pop(context),
                ),
                _buildDrawerItem(
                  icon: Icons.inventory_2_outlined,
                  title: 'Products',
                  context: context,
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Products coming soon'),
                        backgroundColor: AppTheme.accentColor,
                      ),
                    );
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.support_agent_outlined,
                  title: 'Contact Us',
                  context: context,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ContactUsScreen(),
                      ),
                    );
                  },
                ),
                const Divider(height: 32, color: Colors.white24),
                _buildDrawerItem(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  context: context,
                  onTap: () {},
                ),
              ],
            ),
          ),
          _buildDrawerFooter(),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      color: AppTheme.cardColor,
      child: const Row(
        children: [
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "KUBER STEEL",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "INDUSTRIES",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required BuildContext context,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildDrawerFooter() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        'App Version 1.0.0',
        style: TextStyle(color: AppTheme.subtleText),
      ),
    );
  }
}
