class CategoryModel {
  final String name;
  final String image;

  CategoryModel( {required this.name, required this.image});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'] ?? '',
      image: json['image'] ?? 'assets/images/default.jpg',
    );
  }
}

