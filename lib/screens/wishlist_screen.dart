import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: Column(
        children: [
          Expanded(
            child: productProvider.wishlist.isEmpty
                ? Center(
                    child: Text(
                      'Your wishlist is empty!',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                : ListView.builder(
                    itemCount: productProvider.wishlist.length,
                    itemBuilder: (ctx, i) {
                      final product = productProvider.wishlist[i];
                      return ListTile(
                        leading: Image.asset(
                          product.imageAsset,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(product.title),
                        subtitle: Text('\$${product.price}'),
                        trailing: IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            productProvider.removeFromWishlist(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${product.title} removed from wishlist!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: productProvider.wishlist.isEmpty
                  ? null // Disable the button if wishlist is empty
                  : () {
                      productProvider.moveAllToCart(); // Call method to move all items
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('All items moved to cart!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
              child: Text('Move All to Cart'),
            ),
          ),
        ],
      ),
    );
  }
}