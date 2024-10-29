import 'package:flutter/material.dart';

class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({super.key});

  // Custom Colors for reuse
  final Color backgroundColor = const Color(0xFF2C3A3A);
  final Color cardColor = const Color(0xFF243232);

  final Color primaryColor = const Color(0xFF1E4B5F); // Deep steel blue
  final Color secondaryColor = const Color(0xFF2C3E50); // Dark slate
  final Color accentColor = const Color(0xFF34495E); // Medium slate
  final Color textFieldBg = const Color(0xFFF5F6F8); // Light gray
  final Color textColor = const Color(0xFF2D3436); // Dark gray for text
  final Color subtleText = const Color(0xFF7F8C8D); // Subtle gray for hints

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Flexible(
              child: _buildMainContent(),
            ),
            const SizedBox(
              height: 70,
            ),
            Center(
                child: Image.asset(
              'assets/kuber_logo.png',
              height: 90,
            ))
          ],
        ),
      ),
    );
  }

  // AppBar Widget
  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.all(8),
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/kuber_logo.png',
            height: 40,
          ),
          const SizedBox(width: 8),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "KUBERSTEEL",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                "INDUSTRIES",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Main Content Widget
  Widget _buildMainContent() {
    const double space_bet_fields = 4;
    const double horizontal_padding = 40;

    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeaderRow(),
          const SizedBox(height: 4),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 4, horizontal: horizontal_padding),
              margin: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                  const SizedBox(height: 24),
                  _buildInfoContainer(
                    Icons.person,
                    'Username',
                  ),
                  const SizedBox(height: space_bet_fields),
                  _buildInfoContainer(Icons.email, 'Email ID'),
                  const SizedBox(height: space_bet_fields),
                  _buildInfoContainer(Icons.phone, 'Mobile No.'),
                  const SizedBox(height: 24),
                  _buildLogoutButton(),
                ],
              ),
            ),
          ),
          _buildPrivacyPolicyLink(),
        ],
      ),
    );
  }

// Helper method to create a smaller container with text
  Widget _buildInfoContainer(IconData icon, String label) {
    const double height = 30.0;
    const double width = height;
    return Row(
      children: [
        // Circular container for the icon
        Container(
          height: height, // Reduced height for a smaller circular shape
          width: width, // Ensuring width equals height for a perfect circle
          decoration: BoxDecoration(
            color: Colors.white, // White background
            shape: BoxShape.circle, // Make it circular
            border: Border.all(color: Colors.black),
          ),
          child: Center(
            child:
                Icon(icon, size: 16, color: Colors.black), // Smaller black icon
          ),
        ),
        const SizedBox(width: 8), // Spacing between the icon and label
        // Container for the label
        Expanded(
          // Use Expanded to take up remaining space
          child: Container(
            height: height, // Reduced height for a smaller label container
            decoration: BoxDecoration(
              color: Colors.white, // Background color
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 8), // Horizontal padding
            child: Center(
              // Center the text vertically
              child: Text(
                label,
                style: const TextStyle(
                    color: Colors.black87, fontSize: 14), // Reduced font size
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Header Row with Close Button and Logo
  Widget _buildHeaderRow() {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/kuber_logo.png',
              height: 40,
            ),
            const SizedBox(width: 8),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "KUBERSTEEL",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  "INDUSTRIES",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.close, color: Colors.white),
            ),
          ],
        )
      ],
    );
  }

  // Logout Button
  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Add logout logic here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // Transparent background
          padding: const EdgeInsets.symmetric(vertical: 16),
          shadowColor: Colors.transparent, // Remove elevation
          shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.zero, // No border radius for a flat button
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the content
          children: [
            Text(
              'Log out',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(width: 8), // Space between text and icon
            Icon(Icons.logout, color: Colors.white), // Trailing icon
          ],
        ),
      ),
    );
  }

  // Privacy Policy Link
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
