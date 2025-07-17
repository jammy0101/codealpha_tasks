// // add_product_screen.dart
// import 'package:ecommerce/resources/color/color.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../modal/mobile_modal/mobil_modal.dart';
// import '../../viewModal/product_controller/product_controller.dart';
//
// class AddProductScreen extends StatelessWidget {
//   final nameController = TextEditingController();
//   final priceController = TextEditingController();
//   final imageController = TextEditingController();
//   final categoryController = TextEditingController();
//   final descriptionController = TextEditingController();
//
//   final ProductController productController = Get.find();
//
//   AddProductScreen({super.key});
//
//   void addProduct(BuildContext context) {
//     final name = nameController.text.trim();
//     final priceText = priceController.text.trim();
//     final image = imageController.text.trim();
//     final category = categoryController.text.trim();
//     final description = descriptionController.text.trim();
//
//     if (name.isEmpty || priceText.isEmpty || image.isEmpty || category.isEmpty) {
//       Get.snackbar("Missing Fields", "Please fill all fields properly");
//       return;
//     }
//
//     final price = double.tryParse(priceText);
//     if (price == null) {
//       Get.snackbar("Invalid Price", "Please enter a valid price");
//       return;
//     }
//
//     final newProduct = MobileModel(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       name: name,
//       price: price,
//       image: image,
//       category: category,
//       quantity: 1,
//       description: description,
//     );
//
//     productController.uploadProductsToFirestore([newProduct]);
//     Get.back();
//     Get.snackbar("Success", "Product added successfully");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//           backgroundColor: AppColor.wow3,
//           title: const Text("Add Product",style: TextStyle(fontWeight: FontWeight.bold),)),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("Product Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 16),
//             _buildTextField(controller: nameController, label: 'Product Name'),
//             _buildTextField(controller: priceController, label: 'Price', keyboardType: TextInputType.number),
//             _buildTextField(controller: imageController, label: 'Image URL / Path'),
//             _buildTextField(controller: categoryController, label: 'Category'),
//             _buildTextField(controller: descriptionController, label: 'Description', maxLines: 3),
//             const SizedBox(height: 24),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton.icon(
//                 onPressed: () => addProduct(context),
//                 icon: const Icon(Icons.save),
//                 label: const Text("Save Product"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     TextInputType keyboardType = TextInputType.text,
//     int maxLines = 1,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: TextField(
//         controller: controller,
//         keyboardType: keyboardType,
//         maxLines: maxLines,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         ),
//       ),
//     );
//   }
// }
// add_product_screen.dart
import 'package:ecommerce/resources/color/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modal/mobile_modal/mobil_modal.dart';
import '../../viewModal/product_controller/product_controller.dart';

class AddProductScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final imageController = TextEditingController();
  final categoryController = TextEditingController();
  final descriptionController = TextEditingController();

  final ProductController productController = Get.find();

  AddProductScreen({super.key});

  void addProduct(BuildContext context) {
    final name = nameController.text.trim();
    final priceText = priceController.text.trim();
    final image = imageController.text.trim();
    final category = categoryController.text.trim();
    final description = descriptionController.text.trim();

    if (name.isEmpty || priceText.isEmpty || image.isEmpty || category.isEmpty) {
      Get.snackbar("Missing Fields", "Please fill all fields properly");
      return;
    }

    final price = double.tryParse(priceText);
    if (price == null) {
      Get.snackbar("Invalid Price", "Please enter a valid price");
      return;
    }

    final newProduct = MobileModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      price: price,
      image: image,
      category: category,
      quantity: 1,
      description: description,
    );

    productController.uploadProductsToFirestore([newProduct]);
    Get.back();
    Get.snackbar("Success", "Product added successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.wow3,
          title: const Text("Add Product",style: TextStyle(fontWeight: FontWeight.bold),)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Product Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildTextField(controller: nameController, label: 'Product Name'),
            _buildTextField(controller: priceController, label: 'Price', keyboardType: TextInputType.number),
            //_buildTextField(controller: imageController, label: 'Image URL / Path'),
            const SizedBox(height: 8),
            const Text("Select Image Option", style: TextStyle(fontWeight: FontWeight.bold)),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.image),
                    label: const Text("Use Default"),
                    onPressed: () {
                      imageController.text = 'assets/images/de.jpg';
                      Get.snackbar("Default Image Selected", "You can change it anytime.");
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.edit),
                    label: const Text("Enter Custom URL"),
                    onPressed: () {
                      imageController.clear(); // Let user enter manually
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildTextField(controller: imageController, label: 'Image URL (optional)'),

            _buildTextField(controller: categoryController, label: 'Category'),
            _buildTextField(controller: descriptionController, label: 'Description', maxLines: 3),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => addProduct(context),
                icon: const Icon(Icons.save),
                label: const Text("Save Product"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}