import '../productModel/product_Model.dart';

class ProductService {
  List<Product> fetchProducts() {
    return [
      Product(
          id: '1',
          name: 'iPhone 15 Pro',
          description: 'Experience unmatched performance with the iPhone 15 Pro – featuring the powerful A17 Pro chip, advanced triple-camera system, and a stunning Super Retina XDR display, all housed in a sleek titanium design.',
          price: 1500,
          imageUrl: 'assets/images/iphone.png'),
      Product(
          id: '2',
          name: 'Samsung S24 Ultra',
          description: 'Push the limits with the Samsung Galaxy S24 Ultra – powered by the Snapdragon 8 Gen 3, featuring a 200MP pro-grade camera, AI-enhanced performance, and a dynamic AMOLED 2X display for a premium flagship experience.',
          price: 1400,
          imageUrl: 'assets/images/samsung1.png'),

      Product(id: '3', name: 'iPhone 15 Pro', description: 'Latest Apple iPhone', price: 1500, imageUrl: 'assets/images/iphone.png'),
      Product(id: '4', name: 'Samsung S24 Ultra', description: 'Latest Samsung flagship', price: 1400, imageUrl: 'assets/images/samsung1.png'),
    ];
  }
}