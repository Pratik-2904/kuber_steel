import 'package:flutter/material.dart';

import 'home_page.dart';

// Modify your main.dart to use this as the home widget instead of directly using HomePage
class HomeWithOverlay extends StatefulWidget {
  const HomeWithOverlay({super.key});

  @override
  State<HomeWithOverlay> createState() => _HomeWithOverlayState();
}

class _HomeWithOverlayState extends State<HomeWithOverlay> {
  bool _showAccountInfo = false;

  void _toggleAccountInfo() {
    setState(() {
      _showAccountInfo = !_showAccountInfo;
    });
  }

  void _hideAccountInfo() {
    setState(() {
      _showAccountInfo = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Original HomePage
        HomePage(onNotificationPressed: _toggleAccountInfo),

        // Overlay when _showAccountInfo is true
        if (_showAccountInfo) AccountInfoOverlay(onClose: _hideAccountInfo),
      ],
    );
  }
}

// New AccountInfoOverlay widget that creates the modal effect
class AccountInfoOverlay extends StatelessWidget {
  final VoidCallback onClose;

  const AccountInfoOverlay({
    Key? key,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          // padding: const EdgeInsets.symmetric(horizontal: 10),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85,
            maxWidth: MediaQuery.of(context).size.width * 0.95,
          ),
          child: AccountInfoContent(onClose: onClose),
        ),
      ),
    );
  }
}

// Modified version of your AccountInfoScreen to work as an overlay
class AccountInfoContent extends StatelessWidget {
  final VoidCallback onClose;

  const AccountInfoContent({
    Key? key,
    required this.onClose,
  }) : super(key: key);

  // Custom Colors for reuse
  static const Color backgroundColor = Color(0xFF2C3A3A);
  static const Color cardColor = Color(0xFF243232);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
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
                  _buildPrivacyPolicyLink(),
                  // Center(
                  //   child: Image.asset(
                  //     'assets/kuber_logo.png',
                  //     height: 70,
                  //   ),
                  // ),
                  // const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/kuber_logo.png',
                height: 30,
              ),
              const SizedBox(width: 8),
              const Column(
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
        color: Colors.white10,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, size: 30, color: Colors.white),
          ),
          const SizedBox(height: 10),
          _buildInfoContainer(Icons.person, 'Username'),
          const SizedBox(height: spaceBetFields),
          _buildInfoContainer(Icons.email, 'Email ID'),
          const SizedBox(height: spaceBetFields),
          _buildInfoContainer(Icons.phone, 'Mobile No.'),
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

  Widget _buildPrivacyPolicyLink() {
    return TextButton(
      onPressed: () {
        // Add privacy policy navigation logic
      },
      child: const Text(
        'Privacy Policy',
        style: TextStyle(
          color: Colors.white,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
