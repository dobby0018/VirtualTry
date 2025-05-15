import 'package:flutter/material.dart';
import 'package:flutter_vto_project/features/cart/screens/cart_page.dart';
import 'package:flutter_vto_project/features/auth/screens/product_details/checkout_page.dart';

class ProductDetailPage extends StatefulWidget {
  final String name;
  final String seller;
  final String description;
  final double price;
  final List<String> sizes;
  final String imagePath;

  const ProductDetailPage({
    super.key,
    required this.name,
    required this.seller,
    required this.description,
    required this.price,
    required this.sizes,
    required this.imagePath,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Image
            AspectRatio(
              aspectRatio: 3 / 4,
              child: Image.asset(widget.imagePath, fit: BoxFit.cover),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    widget.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 6),

                  // Seller
                  Text(
                    "Seller: ${widget.seller}",
                    style: TextStyle(color: Colors.grey[400]),
                  ),

                  SizedBox(height: 16),

                  // Description
                  Text(
                    widget.description,
                    style: TextStyle(color: Colors.white70),
                  ),

                  SizedBox(height: 16),

                  // Price
                  Text(
                    "₹${widget.price.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 24),

                  // Sizes
                  Text(
                    "Select Size:",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 12,
                    children:
                        widget.sizes.map((size) {
                          final isSelected = selectedSize == size;
                          return ChoiceChip(
                            label: Text(
                              size,
                              style: TextStyle(
                                color: isSelected ? Colors.black : Colors.white,
                              ),
                            ),
                            selected: isSelected,
                            onSelected: (_) {
                              setState(() {
                                selectedSize = size;
                              });
                            },
                            selectedColor: Colors.white,
                            backgroundColor: Colors.grey[800],
                          );
                        }).toList(),
                  ),

                  SizedBox(height: 32),

                  SizedBox(height: 16),

                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (selectedSize == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please select a size."),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CartPage()),
                          );
                        }
                      },

                      child: Text("Add to Cart"),
                    ),
                  ),

                  SizedBox(height: 16),

                  // Buy Now Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (selectedSize == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please select a size."),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => CheckoutPage(
                                    productName: widget.name,
                                    price: widget.price,
                                    selectedSize: selectedSize!,
                                  ),
                            ),
                          );
                        }
                      },

                      child: Text("Buy Now"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
