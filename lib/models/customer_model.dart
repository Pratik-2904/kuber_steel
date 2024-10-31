// Mock Customer Model (you should replace this with your actual model)
class Customer {
  final String id;
  final String name;
  final String mobile;
  final String? shopName;

  Customer({
    required this.id,
    required this.name,
    required this.mobile,
    this.shopName,
  });
}
