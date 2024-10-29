import 'package:flutter/material.dart';
import 'package:kuber_steel/pages/customer_selection/customer_selection_screen.dart';

import '../theme/app_theme.dart';
import 'contact_us_page.dart';

class HomePage extends StatelessWidget {
  final Function? onNotificationPressed;

  HomePage({Key? key, this.onNotificationPressed}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: AppColors.backgroundColor,
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      drawer: buildDrawer(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.primaryColor,
      title: Row(
        children: [
          // Image.asset(
          //   'assets/kuber_logo.png',
          //   height: 40,
          // ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "KUBER STEEL",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                "INDUSTRIES",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.person, color: Colors.white),
          onPressed: () {
            if (onNotificationPressed != null) {
              onNotificationPressed!();
            }
          },
        ),
        const SizedBox(width: 8),
      ],
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primaryColor.withOpacity(0.1),
            AppColors.backgroundColor.withOpacity(0.7),
          ],
        ),
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.business,
                size: 80,
                color: Colors.white.withOpacity(0.9),
              ),
              const SizedBox(height: 24),
              const Text(
                'Welcome to Kuber Steel Industries',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Your Trusted Partner in Steel Solutions',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.subtleText,
                ),
              ),
              const SizedBox(height: 30),
              _buildQuickAccessButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAccessButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildQuickAccessButton(
            icon: Icons.inventory_2_outlined,
            label: 'Products',
            onClick: () {}),
        _buildQuickAccessButton(
            icon: Icons.support_agent_outlined,
            label: 'Support',
            onClick: () {}),
        _buildQuickAccessButton(
            icon: Icons.person_search,
            label: 'Customers',
            onClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              );
            }),
      ],
    );
  }

  Widget _buildQuickAccessButton(
      {required IconData icon,
      required String label,
      required VoidCallback onClick}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.fieldBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            onPressed: onClick,
            icon: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.subtleText,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryColor,
      child: Column(
        children: [
          SizedBox(height: 20),
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
                        backgroundColor: AppColors.accentColor,
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
      color: AppColors.primaryColor,
      child: Row(
        children: [
          // Image.asset('assets/kuber_logo.png', height: 60),
          const SizedBox(width: 12),
          const Column(
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: const Text(
        'App Version 1.0.0',
        style: TextStyle(color: AppColors.subtleText),
      ),
    );
  }
}
