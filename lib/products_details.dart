import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/product_controller.dart';
import 'package:grocery/signup_screen.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;
  final Function(int) onAddToCart;

  ProductDetailPage({
    required this.product,
    required this.onAddToCart,
  });

  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    double price = product['price']; 

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(product['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                product['image'],
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              product['name'],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Rs. $price',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 16),
            Text(
              product['description'],
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Quantity:',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 16),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () => controller.decrement(),
                ),
                Obx(() => Text(
                      '${controller.quantity.value}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => controller.increment(),
                ),
              ],
            ),
            SizedBox(height: 16),
            Obx(() => Text(
                  'Total: Rs. ${controller.calculateTotalPrice(price).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                onAddToCart(controller.quantity.value);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        '${product['name']} added to cart (x${controller.quantity.value})'),
                  ),
                );
              },
              child: Text('Add to Cart'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
