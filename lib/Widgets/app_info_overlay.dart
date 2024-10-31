import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kuber_steel/Widgets/privacy_policy.dart';
import 'package:kuber_steel/Widgets/user_avatar.dart';
import 'package:kuber_steel/theme/app_theme.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AccountInfoOverlay(
      onClose: () {},
      onLogOut: () {},
    ),
  ));
}

class AccountInfoOverlay extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onLogOut;

  const AccountInfoOverlay({
    super.key,
    required this.onClose,
    required this.onLogOut,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        // Background Blur Effect
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 10, sigmaY: 10), // Adjust blur intensity
            child: Container(
              color: Colors.black
                  .withOpacity(0.2), // Adjust the overlay color and opacity
            ),
          ),
        ),

        //foreground as it is
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
              maxWidth: MediaQuery.of(context).size.width * 0.95,
            ),
            child: AccountInfoContent(
              onClose: onClose,
              onLogOut: onLogOut,
              onPrivacyPolicyTap: () {},
            ),
          ),
        ),
      ]),
    );
  }
}

class AccountInfoContent extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onLogOut;

  static const Color backgroundColor =
      AppTheme.accountInfoOverlayBackgroundColor;
  static const Color cardColor = AppTheme.accountInfoOverlaySecBackgroundColor;

  final String imageUrl;
  final String username;
  final String email;
  final String mobileNo;

  final VoidCallback onPrivacyPolicyTap;

  const AccountInfoContent({
    super.key,
    required this.onClose,
    this.imageUrl = 'https://default-image-url.com', // Default image URL
    this.username = 'Guest', // Default username
    this.email = 'example@example.com', // Default email
    this.mobileNo = 'N/A', // default Mobile No
    required this.onLogOut,
    required this.onPrivacyPolicyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeaderRow(),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildMainContent(),
                  const SizedBox(height: 0),
                  privacyPolicyLink(onClick: onPrivacyPolicyTap)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

//No changes in here on
  Widget _buildHeaderRow() {
    return Stack(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "KUBERSTEEL",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "INDUSTRIES",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 8,
          top: 8,
          child: IconButton(
            onPressed: onClose,
            icon: const Icon(Icons.close, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    const double spaceBetFields = 4;
    const double horizontalPadding = 40;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: horizontalPadding,
      ),
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 4,
          ),
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.black45,
            child: Avatar(),
          ),
          const SizedBox(height: 10),
          _buildInfoContainer(Icons.person, username),
          const SizedBox(height: spaceBetFields),
          _buildInfoContainer(Icons.email, email),
          const SizedBox(height: spaceBetFields),
          _buildInfoContainer(Icons.phone, mobileNo),
          const SizedBox(height: 8),
          _buildLogoutButton(),
        ],
      ),
    );
  }

  Widget _buildInfoContainer(IconData icon, String label) {
    const double height = 20.0;
    const double width = height;
    return Row(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black),
          ),
          child: Center(
            child: Icon(icon, size: 16, color: Colors.black),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Add logout logic here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shadowColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Log out',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            SizedBox(width: 8),
            Icon(Icons.logout, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
