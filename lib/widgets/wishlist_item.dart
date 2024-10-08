import 'package:flutter/material.dart';
import '../models/product.dart';

class WishlistItem extends StatelessWidget {
  final Product product;

  const WishlistItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(product.imageUrl),
      title: Text(product.title),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          // Implement removal from wishlist here if needed
        },
      ),
    );
  }
}
