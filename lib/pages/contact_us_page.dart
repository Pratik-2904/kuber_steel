import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.backgroundColor,
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      appBar: const _BuildAppBar(),
      body: _buildContainer(),
    );
  }

  //Main Container
  Container _buildContainer() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppTheme.primaryColor.withOpacity(0),
            AppTheme.backgroundColor.withOpacity(0.5),
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildContactInfoCard(),
              const SizedBox(height: 24),
              _buildContactForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfoCard() {
    return Card(
      color: AppTheme.cardColor,
      elevation: 8,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Get in Touch',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildContactItem(
              icon: Icons.location_on_outlined,
              title: 'Visit Us',
              content: '123 Steel Industrial Area\nMumbai, Maharashtra 400001',
            ),
            const Divider(color: Colors.white24, height: 32),
            _buildContactItem(
              icon: Icons.phone_outlined,
              title: 'Call Us',
              content: '+91 98765 43210\n+91 98765 43211',
            ),
            const Divider(color: Colors.white24, height: 32),
            _buildContactItem(
              icon: Icons.email_outlined,
              title: 'Email Us',
              content: 'info@kubersteel.com\nsupport@kubersteel.com',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.fieldBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: const TextStyle(
                    color: AppTheme.subtleText,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm() {
    return Card(
      color: AppTheme.cardColor,
      elevation: 8,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Send us a Message',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              _buildTextField(
                controller: _nameController,
                label: 'Full Name',
                icon: Icons.person_outline,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _emailController,
                label: 'Email Address',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value!)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _phoneController,
                label: 'Phone Number',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _messageController,
                label: 'Message',
                icon: Icons.message_outlined,
                maxLines: 4,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your message';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Send Message',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppTheme.subtleText),
        prefixIcon: Icon(icon, color: AppTheme.subtleText),
        filled: true,
        fillColor: AppTheme.fieldBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        errorStyle: const TextStyle(color: Colors.redAccent),
      ),
      validator: validator,
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Here you would typically send the form data to your backend
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Thank you for your message. We\'ll get back to you soon.'),
          backgroundColor: AppTheme.accentColor,
        ),
      );
      // Clear form
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _messageController.clear();
    }
  }
}

class _BuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _BuildAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppTheme.primaryColor,
      title: const Text(
        'Contact Us',
        style: TextStyle(color: Colors.white),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

//reference code for the uriLauncher implementation if needed

// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import 'home_page.dart';
//
// class ContactUsScreen extends StatefulWidget {
//   const ContactUsScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ContactUsScreen> createState() => _ContactUsScreenState();
// }
//
// class _ContactUsScreenState extends State<ContactUsScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _messageController = TextEditingController();
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _messageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: AppColors.primaryColor,
//         title: const Text(
//           'Contact Us',
//           style: TextStyle(color: Colors.white),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               AppColors.primaryColor,
//               AppColors.backgroundColor,
//             ],
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 _buildContactInfoCard(),
//                 const SizedBox(height: 24),
//                 _buildContactForm(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildContactInfoCard() {
//     return Card(
//       color: AppColors.cardColor,
//       elevation: 8,
//       shadowColor: Colors.black26,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Get in Touch',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             _buildContactItem(
//               icon: Icons.location_on_outlined,
//               title: 'Visit Us',
//               content: '123 Steel Industrial Area\nMumbai, Maharashtra 400001',
//               onTap: () => _launchMaps(),
//             ),
//             const Divider(color: Colors.white24, height: 32),
//             _buildContactItem(
//               icon: Icons.phone_outlined,
//               title: 'Call Us',
//               content: '+91 98765 43210\n+91 98765 43211',
//               onTap: () => _launchPhone(),
//             ),
//             const Divider(color: Colors.white24, height: 32),
//             _buildContactItem(
//               icon: Icons.email_outlined,
//               title: 'Email Us',
//               content: 'info@kubersteel.com\nsupport@kubersteel.com',
//               onTap: () => _launchEmail(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildContactItem({
//     required IconData icon,
//     required String title,
//     required String content,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(8),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: AppColors.fieldBg,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(icon, color: Colors.white, size: 24),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     content,
//                     style: TextStyle(
//                       color: AppColors.subtleText,
//                       fontSize: 14,
//                       height: 1.5,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildContactForm() {
//     return Card(
//       color: AppColors.cardColor,
//       elevation: 8,
//       shadowColor: Colors.black26,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const Text(
//                 'Send us a Message',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 24),
//               _buildTextField(
//                 controller: _nameController,
//                 label: 'Full Name',
//                 icon: Icons.person_outline,
//                 validator: (value) {
//                   if (value?.isEmpty ?? true) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               _buildTextField(
//                 controller: _emailController,
//                 label: 'Email Address',
//                 icon: Icons.email_outlined,
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value?.isEmpty ?? true) {
//                     return 'Please enter your email';
//                   }
//                   if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                       .hasMatch(value!)) {
//                     return 'Please enter a valid email';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               _buildTextField(
//                 controller: _phoneController,
//                 label: 'Phone Number',
//                 icon: Icons.phone_outlined,
//                 keyboardType: TextInputType.phone,
//                 validator: (value) {
//                   if (value?.isEmpty ?? true) {
//                     return 'Please enter your phone number';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               _buildTextField(
//                 controller: _messageController,
//                 label: 'Message',
//                 icon: Icons.message_outlined,
//                 maxLines: 4,
//                 validator: (value) {
//                   if (value?.isEmpty ?? true) {
//                     return 'Please enter your message';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: _submitForm,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.accentColor,
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   'Send Message',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     TextInputType? keyboardType,
//     int maxLines = 1,
//     String? Function(String?)? validator,
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       maxLines: maxLines,
//       style: const TextStyle(color: Colors.white),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: AppColors.subtleText),
//         prefixIcon: Icon(icon, color: AppColors.subtleText),
//         filled: true,
//         fillColor: AppColors.fieldBg,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         errorStyle: const TextStyle(color: Colors.redAccent),
//       ),
//       validator: validator,
//     );
//   }
//
//   void _submitForm() {
//     if (_formKey.currentState?.validate() ?? false) {
//       // Here you would typically send the form data to your backend
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Text(
//               'Thank you for your message. We\'ll get back to you soon.'),
//           backgroundColor: AppColors.accentColor,
//         ),
//       );
//       // Clear form
//       _nameController.clear();
//       _emailController.clear();
//       _phoneController.clear();
//       _messageController.clear();
//     }
//   }
//
//   void _launchPhone() async {
//     final Uri uri = Uri.parse('tel:+919876543210');
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     }
//   }
//
//   void _launchEmail() async {
//     final Uri uri = Uri.parse('mailto:info@kubersteel.com');
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     }
//   }
//
//   void _launchMaps() async {
//     final Uri uri = Uri.parse(
//         'https://maps.google.com/?q=123+Steel+Industrial+Area+Mumbai');
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     }
//   }
// }
