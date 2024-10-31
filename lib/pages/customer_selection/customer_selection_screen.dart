import 'package:flutter/material.dart';
import 'package:kuber_steel/Widgets/app_drawer.dart';
import 'package:kuber_steel/Widgets/app_top_bar.dart';
import 'package:kuber_steel/pages/customer_selection/customer_details.dart';

import '../../models/customer_model.dart';
import '../../theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  List<Customer> _allCustomers = []; // Full list of customers
  List<Customer> _filteredCustomers = []; // Filtered list based on search
  Customer? _selectedCustomer;
  bool _showAllCustomers =
      true; // Flag to control initial customer list display

  @override
  void initState() {
    super.initState();
    _loadCustomers();
  }

  void _loadCustomers() {
    // Simulating loading customers (replace with actual API or database call)
    _allCustomers = [
      Customer(
          id: '1',
          name: 'John Doe',
          mobile: '1234567890',
          shopName: 'Doe Mart'),
      Customer(
          id: '2',
          name: 'Jane Smith',
          mobile: '9876543210',
          shopName: 'Smith Store'),
      Customer(
          id: '3',
          name: 'Alice Johnson',
          mobile: '5555555555',
          shopName: 'Alice Boutique'),
    ];
  }

  void _searchCustomers(String query) {
    setState(() {
      _showAllCustomers = false;
      if (query.isEmpty) {
        _filteredCustomers = [];
        _showAllCustomers = true;
      } else {
        _filteredCustomers = _allCustomers.where((customer) {
          return customer.name.toLowerCase().contains(query.toLowerCase()) ||
              customer.mobile.contains(query) ||
              (customer.shopName?.toLowerCase().contains(query.toLowerCase()) ??
                  false);
        }).toList();
      }
    });
  }

  void _selectCustomer(Customer customer) {
    setState(() {
      // If the same customer is selected again, deselect
      if (_selectedCustomer == customer) {
        _selectedCustomer = null;
        _searchController.clear();
        _showAllCustomers = true;
        _filteredCustomers = [];
      } else {
        _selectedCustomer = customer;
        _searchController.text = customer.name;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: const AppDrawer(),
      appBar: CustomAppBar(
          trailingIcon: Icons.person,
          onIconPressed: () => _scaffoldKey.currentState?.openDrawer()),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppTheme.primaryColor.withOpacity(0),
          AppTheme.backgroundColor.withOpacity(0.7),
        ],
      )),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            _buildSearchContainer(),
            const SizedBox(height: 20),
            _buildSearchResultsList(),
            const SizedBox(height: 20),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage('assets/Text_bg.png'),
          fit: BoxFit.cover,
          alignment: Alignment(-0.8, 0),
          opacity: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: Container(
        margin: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
          bottom: 30,
        ),
        height: 40,
        alignment: Alignment.center,
        child: TextField(
          controller: _searchController,
          onChanged: _searchCustomers,
          style: const TextStyle(height: 1.0),
          decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: 'Name / Mobile / Shop Name etc.',
            hintStyle: TextStyle(
              color: Colors.black.withOpacity(0.4),
            ),
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResultsList() {
    // Check if search query doesn't match any customers
    if (!_showAllCustomers &&
        _filteredCustomers.isEmpty &&
        _searchController.text.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Icon(
              Icons.search_off,
              color: Colors.grey[600],
              size: 50,
            ),
            const SizedBox(height: 10),
            Text(
              'Customer not found',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement add new customer functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Add New Customer')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
              ),
              child: const Text('Add New Customer'),
            ),
          ],
        ),
      );
    }

    // Determine which list to show
    List<Customer> customerList = _showAllCustomers
        ? _allCustomers
        : (_filteredCustomers.isNotEmpty ? _filteredCustomers : _allCustomers);

    // Display search results or all customers
    return Container(
      height: 200, // Adjust as needed
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        itemCount: customerList.length,
        itemBuilder: (context, index) {
          final customer = customerList[index];
          return ListTile(
            title: Text(customer.name),
            subtitle: Text(customer.mobile),
            trailing: Text(customer.shopName ?? 'No Shop'),
            onTap: () => _selectCustomer(customer),
            selected: _selectedCustomer == customer,
            selectedColor: Colors.blue,
          );
        },
      ),
    );
  }

  // Widget _buildSearchResultsList() {
  //   // Determine which list to show
  //   List<Customer> customerList = _showAllCustomers
  //       ? _allCustomers
  //       : (_filteredCustomers.isNotEmpty ? _filteredCustomers : _allCustomers);
  //
  //   // No results found
  //   if (customerList.isEmpty) {
  //     return Container(
  //       padding: const EdgeInsets.all(16),
  //       decoration: BoxDecoration(
  //         color: Colors.grey[200],
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       child: Column(
  //         children: [
  //           Icon(
  //             Icons.search_off,
  //             color: Colors.grey[600],
  //             size: 50,
  //           ),
  //           const SizedBox(height: 10),
  //           Text(
  //             'No customers found',
  //             style: TextStyle(
  //               color: Colors.grey[600],
  //               fontSize: 16,
  //             ),
  //           ),
  //           const SizedBox(height: 10),
  //           ElevatedButton(
  //             onPressed: () {
  //               // TODO: Implement add new customer functionality
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 const SnackBar(content: Text('Add New Customer')),
  //               );
  //             },
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: Colors.blue[700],
  //             ),
  //             child: const Text('Add New Customer'),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  //
  //   // Display search results or all customers
  //   return Container(
  //     height: 200, // Adjust as needed
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(10),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.2),
  //           spreadRadius: 2,
  //           blurRadius: 5,
  //           offset: const Offset(0, 2),
  //         ),
  //       ],
  //     ),
  //     child: ListView.builder(
  //       itemCount: customerList.length,
  //       itemBuilder: (context, index) {
  //         final customer = customerList[index];
  //         return ListTile(
  //           title: Text(customer.name),
  //           subtitle: Text(customer.mobile),
  //           trailing: Text(customer.shopName ?? 'No Shop'),
  //           onTap: () => _selectCustomer(customer),
  //           selected: _selectedCustomer == customer,
  //           selectedColor: Colors.blue,
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              // TODO: Implement add new customer functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Add New Customer')),
              );
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(30, 20),
              backgroundColor: const Color(0xFF708090),
              padding: const EdgeInsets.symmetric(vertical: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'ADD NEW',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: _selectedCustomer != null
                ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Selected: ${_selectedCustomer!.name}'),
                      ),
                    );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerDetailsPage(
                                  customer: _selectedCustomer!,
                                )));
                  }
                : null,
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(30, 20),
              backgroundColor: _selectedCustomer != null
                  ? const Color(0xFF1B2631)
                  : Colors.grey,
              padding: const EdgeInsets.symmetric(vertical: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'NEXT',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

// class SearchScreen extends StatelessWidget {
//   SearchScreen({super.key});
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       // Assign the global key to Scaffold
//       backgroundColor: Colors.white,
//       drawer: const AppDrawer(),
//       appBar: CustomAppBar(trailingIcon: Icons.person, onIconPressed: () {}),
//       body: _buildBody(),
//     );
//   }
//
//   Widget _buildBody() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//           gradient: LinearGradient(
//         begin: Alignment.topCenter,
//         end: Alignment.bottomCenter,
//         colors: [
//           AppTheme.primaryColor.withOpacity(0),
//           AppTheme.backgroundColor.withOpacity(0.7),
//         ],
//       )),
//       child: Column(
//         children: [
//           const SizedBox(height: 40),
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               image: const DecorationImage(
//                 image: AssetImage(
//                     'assets/Text_bg.png'), // Replace with your image path
//                 fit: BoxFit.cover,
//                 alignment: Alignment(-0.8, 0),
//                 opacity: 0.8,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             padding: const EdgeInsets.all(15), // Padding inside the container
//             child: Container(
//               margin: const EdgeInsets.only(
//                 left: 10,
//                 right: 10,
//                 top: 10,
//                 bottom: 30,
//               ),
//               // Set a fixed height for a smaller TextField
//               height: 40, // Adjust this value to make it smaller
//               alignment: Alignment.center,
//               child: TextField(
//                 style: const TextStyle(height: 1.0),
//                 // Control the text height
//                 decoration: InputDecoration(
//                   alignLabelWithHint: true,
//                   hintText: 'Name / Mobile / Shop Name etc.',
//                   hintStyle: TextStyle(
//                     color: Colors.black
//                         .withOpacity(0.4), // Optional: Adjust hint text color
//                   ),
//                   prefixIcon: const Icon(Icons.search),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide.none,
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding: const EdgeInsets.symmetric(
//                       vertical: 10,
//                       horizontal: 10), // Adjust padding for vertical centering
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Row(
//             children: [
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     fixedSize: const Size(30, 20),
//                     backgroundColor: const Color(0xFF708090),
//                     padding: const EdgeInsets.symmetric(vertical: 4),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: const Text(
//                     'ADD NEW',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     fixedSize: const Size(30, 20),
//                     backgroundColor: const Color(0xFF1B2631),
//                     padding: const EdgeInsets.symmetric(vertical: 4),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: const Text(
//                     'NEXT',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
