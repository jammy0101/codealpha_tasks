

import 'package:ecommerce/resources/color/color.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final List<Map<String, String>> cards = [
    {
      'brand': 'Visa',
      'number': '**** **** **** 4242',
      'holder': 'John Doe',
      'expiry': '04/26'
    },
    {
      'brand': 'MasterCard',
      'number': '**** **** **** 4444',
      'holder': 'Jane Smith',
      'expiry': '12/25'
    },
  ];

  final TextEditingController emailController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent(amountController.text, 'USD');

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          merchantDisplayName: 'ChannelXplode',
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      await _firestore.collection('payments').add({
        'email': emailController.text.trim(),
        'amount': amountController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      Get.snackbar("Success", "Payment completed and saved to Firestore");
      emailController.clear();
      amountController.clear();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    throw UnimplementedError('Connect to backend for secure payment intent creation.');
  }

  final List<Color> cardColors = [
    Colors.deepPurpleAccent,
    Colors.teal,
    Colors.indigo,
    Colors.pinkAccent,
    Colors.orangeAccent
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.wow3,
      appBar: AppBar(
        centerTitle: true,
          backgroundColor: AppColor.wow2,
          title: const Text("Payment")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Enter Email", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your email',
              ),
            ),
            const SizedBox(height: 16),
            const Text("Enter Amount (USD)", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter amount',
              ),
            ),
            const SizedBox(height: 24),
            const Text("Select a Card", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                viewportFraction: 0.8,
              ),
              items: cards.asMap().entries.map((entry) {
                final index = entry.key;
                final card = entry.value;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    elevation: 10,
                    shadowColor: cardColors[index % cardColors.length].withOpacity(0.5),
                    color: cardColors[index % cardColors.length],
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(card['brand']!, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          Text(card['number']!, style: const TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 1.5)),
                          const SizedBox(height: 12),
                          Text("${card['holder']} | ${card['expiry']}", style: const TextStyle(color: Colors.white70, fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => makePayment(),
                child: const Text("Pay Now", style: TextStyle(fontSize: 18)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
