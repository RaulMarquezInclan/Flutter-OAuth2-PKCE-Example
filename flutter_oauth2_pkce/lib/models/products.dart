import 'package:meta/meta.dart';

class Product {
  Product({
    @required this.productId,
    @required this.name,
    @required this.category,
    @required this.color,
    @required this.unitPrice,
    @required this.availableQuantity,
  });

  int productId;
  String name;
  String category;
  String color;
  int unitPrice;
  int availableQuantity;

  factory Product.fromJson(Map<String, dynamic> prods) {
    return Product(
      productId: prods['productId'],
      name: prods['name'],
      category: prods['category'],
      color: prods['color'],
      unitPrice: prods['unitPrice'],
      availableQuantity: prods['availableQuantity'],
    );
  }
}
