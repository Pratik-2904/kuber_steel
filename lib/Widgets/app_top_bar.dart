import 'package:flutter/material.dart';
import 'package:kuber_steel/theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconData trailingIcon;
  final Function? onIconPressed;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final String title;
  final String subtitle;

  const CustomAppBar({
    super.key,
    required this.trailingIcon,
    required this.onIconPressed,
    this.scaffoldKey,
    this.title = "KUBER STEEL",
    this.subtitle = "INDUSTRIES",
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppTheme.cardColor,
      // Or AppTheme.primaryColor if available
      title: Row(
        children: [
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
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
          icon: Icon(trailingIcon, color: Colors.white),
          onPressed: () {
            if (onIconPressed != null) {
              onIconPressed!();
            }
          },
        ),
        const SizedBox(width: 8),
      ],
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () => scaffoldKey?.currentState?.openDrawer(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
