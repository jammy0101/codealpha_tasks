
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/modal/mobile_modal/mobil_modal.dart';
import 'package:ecommerce/resources/color/color.dart';
import 'package:ecommerce/resources/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../modal/ProductDetailScreen/ProductDetailScreen.dart';
import '../../resources/customDrawer/bottumNavigation.dart';
import '../../resources/customDrawer/drawer.dart';
import '../../viewModal/product_controller/product_controller.dart';
import '../cart/cartScreen.dart';

class buyerDashboard extends StatefulWidget {
  @override
  State<buyerDashboard> createState() => _buyerDashboardState();
}

class _buyerDashboardState extends State<buyerDashboard> {
  final ProductController productController = Get.put(ProductController());

  List<String> banners = [
    'assets/images/shop.jpg',
    'assets/images/mobile.jpeg',
    'assets/images/samsung1.png',
  ];
  final RxString searchQuery = ''.obs;

  Future<void> _refreshProducts() async {
    await productController.loadProducts();

  }

  @override
  void initState() {
    super.initState();
    //productController.uploadProductsToFirestore(); // ✅ Remove after one-time run
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: Text('Mobile Shop'),
        centerTitle: true,
        backgroundColor: AppColor.wow3,
        actions: [
          Obx(() {
            int count = productController.cartItemCount;
            return Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart, color: AppColor.wow1),
                  onPressed: () => Get.toNamed(RoutesName.cartScreen),
                ),
                if (count > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$count',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
      bottomNavigationBar: BottomNavigation(index: 0),
      drawer: CustomDrawer(auth: FirebaseAuth.instance),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.25,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                enlargeCenterPage: true,
                viewportFraction: 0.85,
              ),
              items: banners.map((banner) {
                return Builder(
                  builder: (context) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              banner,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                            Positioned(
                              bottom: 12,
                              left: 12,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                color: Colors.black.withOpacity(0.8),
                                child: Text(
                                  "50% OFF",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 30,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (value) => searchQuery.value = value.toLowerCase(),
                style: TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Search for mobiles...',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  prefixIcon: Icon(Icons.search, color: Colors.black54),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              final query = searchQuery.value.trim();
              final filteredProducts = query.isEmpty
                  ? productController.products
                  : productController.products
                  .where((product) =>
              product.name.toLowerCase().contains(query) ||
                  product.description.toLowerCase().contains(query))
                  .toList();
            
              if (filteredProducts.isEmpty) {
                return Center(child: Text("No products found."));
              }
            
              return RefreshIndicator(
                onRefresh: _refreshProducts,
                child: GridView.builder(
                  padding: const EdgeInsets.all(14),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.60,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (_, index) {
                    final product = filteredProducts[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => ProductDetailScreen(product: product));
                      },
                      child: Card(
                        color: AppColor.wow3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Hero(
                                    tag: product.id,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        product.image,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 1,
                                    right: 2,
                                    child: Obx(() => IconButton(
                                      icon: Icon(
                                        productController.favorites.contains(product.id)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.redAccent,
                                      ),
                                      onPressed: () => productController.toggleFavorite(product.id),
                                    )),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(product.name, style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Text("\$${product.price}"),
                            ElevatedButton(
                              onPressed: () {
                                productController.addToCart(product);
                              },
                              child: Text("Add to Cart"),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          )

        ],
      ),
    );
  }
}
