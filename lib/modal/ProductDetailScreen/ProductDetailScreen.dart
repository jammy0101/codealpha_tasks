import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/modal/mobile_modal/mobil_modal.dart';
import 'package:ecommerce/resources/color/color.dart';
import 'package:ecommerce/viewModal/firebase_services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class ProductDetailScreen extends StatefulWidget {
  final MobileModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseServices firebaseServices = Get.put(FirebaseServices());
  double currentRating = 0.0;
  int quantityToAdd = 1; // place inside StatefulWidget


  @override
  void initState() {
    super.initState();
    fetchUserRating();
  }

  Future<void> saveRatingToFirestore(double rating) async {
    if (auth.currentUser == null) {
      Get.snackbar("Error", "User not logged in");
      return;
    }
    final String userId = auth.currentUser!.uid;

    final userDoc = await FirebaseFirestore.instance
        .collection('users_profile')
        .doc(userId)
        .get();
    final userName = userDoc.data()?['name'] ?? 'Unknown';

    final ratingRef = FirebaseFirestore.instance
        .collection('product_ratings')
        .doc(widget.product.id)
        .collection('user_ratings')
        .doc(userId);

    await ratingRef.set({
      'rating': rating,
      'timestamp': FieldValue.serverTimestamp(),
      'userName': userName,
    });
  }

  Future<void> fetchUserRating() async {
    if (auth.currentUser == null) {
      Get.snackbar("Error", "User not logged in");
      return;
    }
    final userId = auth.currentUser!.uid;

    final doc = await FirebaseFirestore.instance
        .collection('product_ratings')
        .doc(widget.product.id)
        .collection('user_ratings')
        .doc(userId)
        .get();

    if (doc.exists) {
      setState(() {
        currentRating = doc['rating'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: Text(
          widget.product.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: AppColor.wow2,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: widget.product.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    widget.product.image,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                widget.product.name,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  RatingBar.builder(
                    initialRating: currentRating,
                    minRating: 1,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 30,
                    itemBuilder: (context, _) =>
                    const Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (rating) {
                      setState(() => currentRating = rating);
                      saveRatingToFirestore(rating);
                    },
                  ),
                  const SizedBox(width: 10),
                  Text(currentRating.toStringAsFixed(1),
                      style: const TextStyle(fontSize: 18)),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                widget.product.description,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${widget.product.price}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Add to cart logic here using MobileModel
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.wow2,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Add to Cart",
                      style:
                      TextStyle(fontSize: 16, color: AppColor.whiteColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
