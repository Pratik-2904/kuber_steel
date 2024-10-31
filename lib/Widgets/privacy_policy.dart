import 'package:flutter/material.dart';

Widget privacyPolicyLink({required onClick}) {
  return TextButton(
    onPressed: onClick,
    child: const Text(
      'Privacy Policy',
      style: TextStyle(
        color: Colors.white,
        decoration: TextDecoration.underline,
      ),
    ),
  );
}
