import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  final String productName;
  final double price;
  final String selectedSize;

  const CheckoutPage({
    super.key,
    required this.productName,
    required this.price,
    required this.selectedSize,
  });

  @override
  Widget build(BuildContext context) {
    double total = price;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Product Details
            Text(
              "Product: $productName",
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              "Size: $selectedSize",
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              "Price: ₹${price.toStringAsFixed(2)}",
              style: const TextStyle(color: Colors.greenAccent, fontSize: 16),
            ),
            const Divider(color: Colors.white12, height: 30),

            // Total
            Text(
              "Total: ₹${total.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
            const Spacer(),

            // Place Order Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (_) => AlertDialog(
                          title: const Text('Order Confirmed!'),
                          content: const Text(
                            'Your order has been placed successfully.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(
                                  context,
                                ).popUntil((route) => route.isFirst);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                  );
                },
                child: const Text("Place Order"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
