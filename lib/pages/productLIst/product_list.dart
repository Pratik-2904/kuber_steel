import 'package:flutter/material.dart';
import 'package:kuber_steel/pages/productLIst/product_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OrderPage(),
    );
  }
}

class OrderPage extends StatelessWidget {
  // List of products
  final List<Product> products = [
    Product('CC', Icons.circle),
    Product('GC', Icons.golf_course),
    Product('Pipes', Icons.line_axis),
    Product('Channel', Icons.grid_view),
    Product('Angles', Icons.panorama_wide_angle_select),
    Product('F/R/S', Icons.list),
    Product('Heavy section', Icons.select_all),
    // Add new products here
    Product('New Product', Icons.new_releases),
    // Example of adding a new product
  ];

  OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order for Mr. Gaurav'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return OrderItem(product: products[index]);
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                // Handle back action
              },
              child: Text('BACK'),
            ),
            TextButton(
              onPressed: () {
                // Handle next action
              },
              child: Text('NEXT'),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final Product product;

  const OrderItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(product.icon, size: 50),
        const SizedBox(height: 8),
        Text(product.label, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
