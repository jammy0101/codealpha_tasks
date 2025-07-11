import '../productModel/product_Model.dart';

class ProductService {
  List<Product> fetchProducts() {
    return [
      Product(
        id: '1',
        name: 'iPhone 15 Pro',
        description:
            'Experience unmatched performance with the iPhone 15 Pro – featuring the powerful A17 Pro chip, advanced triple-camera system, and a stunning Super Retina XDR display, all housed in a sleek titanium design.',
        price: 1500,
        imageUrl: 'assets/images/iphone.png',
      ),
      Product(
        id: '2',
        name: 'Samsung S24 Ultra',
        description:
            'Push the limits with the Samsung Galaxy S24 Ultra – powered by the Snapdragon 8 Gen 3, featuring a 200MP pro-grade camera, AI-enhanced performance, and a dynamic AMOLED 2X display for a premium flagship experience.',
        price: 1400,
        imageUrl: 'assets/images/samsung1.png',
      ),

      Product(
        id: '3',
        name: 'Infinix hot 10',
        description:
            'The Infinix Hot 10 is a budget-friendly smartphone designed for smooth performance and entertainment.',
        price: 600,
        imageUrl: 'assets/images/infinixhot10.jpg',
      ),
      Product(
        id: '4',
        name: 'xiaomi Redme 13C',
        description:
            "The Redmi 13C delivers a large and smooth screen, capable day-to-day performance, and long battery life—all at an accessible price point. It's a great pick for casual users, students, or as a secondary device, though you might notice camera and performance limitations at this budget level",
        price: 999,
        imageUrl: 'assets/images/RedMe.png',
      ),
      Product(
        id: '5',
        name: 'vivo y 15',
        description:
            "The Vivo Y15 is a solid choice for budget-conscious users needing a large screen, reliable battery, and versatile camera setup. Ideal for daily use, social media, and media playback—but don’t expect top-tier gaming performance.",
        price: 300,
        imageUrl: 'assets/images/vivo.jpg',
      ),
      Product(
        id: '6',
        name: 'oppo',
        description:
            "A stylish and affordable handset, the OPPO A15 delivers reliable performance, decent battery life, and solid camera capabilities for basic users. However, it remains on Android 10 and isn’t designed for gaming or advanced tasks ",
        price: 450,
        imageUrl: 'assets/images/opoo.jpg',
      ),
    ];
  }
}
