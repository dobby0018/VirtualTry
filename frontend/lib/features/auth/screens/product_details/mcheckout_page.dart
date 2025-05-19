import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  const CheckoutPage({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    double total = cartItems.fold(
      0,
      (sum, item) => sum + (item["price"] as double) * item["quantity"],
    );

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

            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (_, index) {
                  final item = cartItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Product: ${item["productName"] ?? "N/A"}",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Size: ${item["selectedSize"] ?? "Not selected"}",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Price: ₹${(item['price'] as double).toStringAsFixed(2)} x ${item['quantity']}",
                          style: const TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 16,
                          ),
                        ),
                        const Divider(color: Colors.white12),
                      ],
                    ),
                  );
                },
              ),
            ),

            Text(
              "Total: ₹${total.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.greenAccent,
              ),
            ),
            const SizedBox(height: 20),

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
