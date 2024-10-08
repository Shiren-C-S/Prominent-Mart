import 'package:flutter/material.dart';
import 'package:mart/screens/product_details_screen.dart';
import 'package:provider/provider.dart';
import './screens/home_screen.dart';
import './screens/cart_screen.dart';
import './screens/wishlist_screen.dart';
import './providers/product_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mera Mart',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomeScreen(),
      routes: {
        '/cart': (context) => CartScreen(),
        '/wishlist': (context) => WishlistScreen(),
        '/product-details': (context) => ProductDetailsScreen(ModalRoute.of(context)!.settings.arguments as String),
      },
    );
  }
}
