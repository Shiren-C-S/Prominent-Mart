import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    double totalCost = 0.0; 
   
    productProvider.cart.forEach((product) {// Ensure product.price is not null
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: productProvider.cart.length,
              itemBuilder: (ctx, i) {
                final product = productProvider.cart[i];
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
                      productProvider.removeFromCart(product);
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Text('${product.title} removed from cart!'),
                      //     duration: Duration(seconds: 2),
                      //   ),
                      // );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total: \$${totalCost.toStringAsFixed(2)}', 
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle checkout
            },
            child: Text('Checkout'),
          ),
        ],
      ),
    );
  }
}
