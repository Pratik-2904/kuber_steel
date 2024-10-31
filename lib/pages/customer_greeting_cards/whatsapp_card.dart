import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../contact_us_page.dart';
import '../home_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WhatsappCard(),
  ));
}

class WhatsappCard extends StatelessWidget {
  WhatsappCard({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Set the key for the scaffold
      appBar: _buildAppBar(),
      drawer: buildDrawer(context),
      body: buildMainContent(), // Ensure body is included
    );
  }

  Widget buildMainContent() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryColor.withOpacity(0),
            AppTheme.backgroundColor.withOpacity(0.5),
          ],
        ),
      ),
      child: Column(children: [
        const SizedBox(
          height: 30,
        ),
        buildMainCard(),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Share Via Whatsapp ",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Icon(Icons.ios_share)
          ],
        )
      ]),
    );
  }

  Widget buildMainCard() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 320),
      alignment: Alignment.center,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: const Color(0xFF212f31),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Ensure only required space is taken
        children: [
          _buildLogo(),
          const Text(
            "Whatsapp",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 20),
          _buildOrderConfirmedRow(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      padding: const EdgeInsets.all(30),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        'assets/whatsapp.png',
        height: 60,
        fit: BoxFit.contain, // Maintain aspect ratio
      ),
    );
  }

  Widget _buildOrderConfirmedRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Order Confirmed!",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(width: 8), // Added spacing between text and icon
        Container(
          alignment: Alignment.center,
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: const Color(0xFF00d26a),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Icon(
            Icons.check,
            color: Colors.white,
            size: 20,
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF1B2631),
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'KUBER STEEL',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'INDUSTRIES',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.person_outline, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.primaryColor,
      child: Column(
        children: [
          _buildDrawerHeader(),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              color: AppTheme.cardColor,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(
                    icon: Icons.home_outlined,
                    title: 'Home',
                    context: context,
                    onTap: () => Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage())),
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
                            builder: (context) => const ContactUsScreen()),
                      );
                    },
                  ),
                  const Divider(
                    height: 32,
                    color: Colors.white24,
                  ),
                  _buildDrawerItem(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    context: context,
                    onTap: () {},
                  ),
                ],
              ),
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
      decoration: const BoxDecoration(
        color: AppTheme.primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/kuber_logo.png',
                height: 60,
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "KUBER STEEL",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "INDUSTRIES",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: title == 'Home' ? AppTheme.fieldBg : Colors.transparent,
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: onTap,
        dense: true,
        horizontalTitleGap: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      ),
    );
  }

  Widget _buildDrawerFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppTheme.cardColor,
      child: const Column(
        children: [
          Divider(color: Colors.white24),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'App Version 1.0.0',
                style: TextStyle(
                  color: AppTheme.subtleText,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
