import 'package:flutter/material.dart';

import '../Widgets/app_info_overlay.dart';
import 'home_page.dart';

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
        HomePage(onIconPressed: _toggleAccountInfo),
        // Overlay when _showAccountInfo is true
        if (_showAccountInfo)
          AccountInfoOverlay(
            onClose: _hideAccountInfo,
            //TODO Add logout functionality
            onLogOut: () {},
          ),
      ],
    );
  }
}
