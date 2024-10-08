import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges; // Use prefix 'badges'
import '../providers/product_provider.dart';
import './search_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 195, 160, 255),
        title: Text('Prominent Mart', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
          // Cart button with badge using 'badges' prefix
          Consumer<ProductProvider>(
            builder: (_, productProvider, child) => badges.Badge(
              badgeContent: Text(
                productProvider.cart.length.toString(),
                style: TextStyle(color: Colors.white),
              ),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed('/cart');
                },
              ),
            ),
          ),
          // Wishlist button with badge using 'badges' prefix
         Consumer<ProductProvider>(
  builder: (_, productProvider, child) => badges.Badge(
    badgeContent: Text(
      productProvider.wishlist.length.toString(),
      style: TextStyle(color: Colors.white),
    ),
    child: IconButton(
      icon: Icon(Icons.favorite),
      onPressed: () {
        Navigator.of(context).pushNamed('/wishlist');
      },
    ),
  ),
),

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: productProvider.products.length,
          itemBuilder: (ctx, i) {
            final product = productProvider.products[i];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  '/product-details',
                  arguments: product.id,
                );
              },
              child: Card(
                elevation: 4, // Adds shadow to the card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(15)), // Rounded top corners
                        child: Image.asset(
                          product.imageAsset, // Use Image.asset for local images
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(height: 4),
                          Text(
                            '\$${product.price}',
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            product.isFavourite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: product.isFavourite
                                ? Colors.red
                                : Colors.grey,
                          ),
                          onPressed: () {
                            productProvider.toggleFavourite(product);
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(
                            //     content: Text(
                            //       '${product.isFavourite ? "Added to" : "Removed from"} favorites!',
                            //     ),
                            //     duration: Duration(seconds: 2),
                            //   ),
                            // );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.add_shopping_cart),
                          onPressed: () {
                            productProvider.addToCart(product);
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(
                            //     content: Text('${product.title} added to cart!'),
                            //     duration: Duration(seconds: 2),
                            //   ),
                            // );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
