import 'package:flutter/material.dart';
import 'package:mart/providers/product_provider.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final cartItems = productProvider.cart;

    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),  // Icon to clear all history
            onPressed: () {
              if (cartItems.isNotEmpty) {
                productProvider.clearHistory();  // Clear all history
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('History cleared!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: cartItems.isEmpty
          ? Center(child: Text('No history available.'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (ctx, i) {
                final product = cartItems[i];
                return ListTile(
                  title: Text(product.title),
                  subtitle: Text(product.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('\$${product.price.toStringAsFixed(2)}'),
                      IconButton(
                        icon: Icon(Icons.delete),  // Delete icon for individual items
                        onPressed: () {
                          productProvider.removeFromHistory(product);  // Remove individual item
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product.title} removed from history!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  leading: Icon(
                    product.isFavourite ? Icons.favorite : Icons.favorite_border,
                    color: product.isFavourite ? Colors.red : null,
                  ),
                );
              },
            ),
    );
  }
}
