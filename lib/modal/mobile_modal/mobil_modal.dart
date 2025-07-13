
class MobileModel {
  final String id;
  final String name;
  final String image;
  final String category; // e.g., "Samsung", "Vivo"
  final double price;
  final String description;
  int quantity;

  MobileModel({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.price,
    required this.description,
    this.quantity = 1,
  });

  MobileModel copyWith({int? quantity}) {
    return MobileModel(
      id: id,
      name: name,
      image: image,
      category: category,
      price: price,
      description: description,
      quantity: quantity ?? this.quantity,
    );
  }

  factory MobileModel.fromJson(Map<String, dynamic> json) {
    return MobileModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      category: json['category'],
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'category': category,
      'price': price,
      'description': description,
      'quantity': quantity,
    };
  }
}
