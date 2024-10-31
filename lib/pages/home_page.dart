import 'package:flutter/material.dart';
import 'package:kuber_steel/Widgets/app_drawer.dart';
import 'package:kuber_steel/Widgets/app_top_bar.dart';
import 'package:kuber_steel/pages/contact_us_page.dart';
import 'package:kuber_steel/pages/customer_selection/customer_selection_screen.dart';

import '../theme/app_theme.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  final Function? onIconPressed;

  HomePage({super.key, this.onIconPressed});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        trailingIcon: Icons.person,
        onIconPressed: onIconPressed,
        scaffoldKey: _scaffoldKey,
      ),
      drawer: const AppDrawer(),
      body: _buildBody(context),
    );
  }

  //Completed No changes needed
  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppTheme.primaryColor.withOpacity(0.1),
            AppTheme.backgroundColor.withOpacity(0.7),
          ],
        ),
      ),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppTheme.cardColor,
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
              const Text(
                'Your Trusted Partner in Steel Solutions',
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.subtleText,
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
            onClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ContactUsScreen(),
                ),
              );
            }),
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
            color: AppTheme.fieldBg,
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
            color: AppTheme.subtleText,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
