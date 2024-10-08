import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;

  ProductDetailsScreen(this.productId);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final product = productProvider.findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        backgroundColor: const Color.fromARGB(255, 195, 160, 255),
      ),
      body: Column(
        children: [
          Image.asset(product.imageAsset),
          SizedBox(height: 10),
          Text(
            '\$${product.price}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            product.description,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  productProvider.addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added to cart!'),
                    ),
                  );
                },
                child: Text('Add to Cart'),
              ),
              ElevatedButton(
                onPressed: () {
                  productProvider.addToWishlist(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added to wishlist!'),
                    ),
                  );
                },
                child: Text('Add to Wishlist'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
