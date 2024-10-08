import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [
    Product(
      id: '1',
      title: 'Samsung Galaxy S21 Ultra',
      imageAsset: 'assets/images/samsung_galaxy_s21_ultra.png',
      price: 999.99,
      description: 'The Samsung Galaxy S21 Ultra is a premium smartphone with a stunning display, top-notch cameras, and powerful performance.',
    ),
    Product(
      id: '2',
      title: 'PlayStation 5',
      imageAsset: 'assets/images/playstation_5.png',
      price: 499.99,
      description: 'Experience lightning-fast loading with an ultra-high-speed SSD and immerse yourself in breathtaking graphics with the PS5.',
    ),
    Product(
      id: '3',
      title: 'Bose QC35 II',
      imageAsset: 'assets/images/bose_qc35_ii.png',
      price: 299.99,
      description: 'Enjoy the world\'s best noise-canceling headphones with superior sound quality and all-day comfort.',
    ),
    Product(
      id: '4',
      title: 'Apple iPhone 13',
      imageAsset: 'assets/images/iphone_13.png',
      price: 799.99,
      description: 'The iPhone 13 features an advanced dual-camera system, improved battery life, and the powerful A15 Bionic chip.',
    ),
    Product(
      id: '5',
      title: 'Google Pixel 6',
      imageAsset: 'assets/images/google_pixel_6.png',
      price: 599.99,
      description: 'Capture stunning photos with the Google Pixel 6, powered by the Google Tensor chip for an enhanced camera experience.',
    ),
    Product(
      id: '6',
      title: 'OnePlus 9 Pro',
      imageAsset: 'assets/images/oneplus_9_pro.png',
      price: 969.99,
      description: 'The OnePlus 9 Pro offers a stunning display, lightning-fast performance, and excellent camera capabilities.',
    ),
    Product(
      id: '7',
      title: 'Samsung Galaxy Watch 4',
      imageAsset: 'assets/images/samsung_galaxy_watch_4.png',
      price: 249.99,
      description: 'Track your fitness and stay connected with the Samsung Galaxy Watch 4, featuring advanced health metrics and apps.',
    ),
    Product(
      id: '8',
      title: 'Sony WH-1000XM4',
      imageAsset: 'assets/images/sony_wh1000xm4.png',
      price: 349.99,
      description: 'Experience the best in noise cancellation with the Sony WH-1000XM4 headphones, offering premium sound and comfort.',
    ),
    Product(
      id: '9',
      title: 'Apple MacBook Pro M1',
      imageAsset: 'assets/images/macbook_pro_m1.png',
      price: 1299.99,
      description: 'The Apple MacBook Pro with M1 chip offers unmatched performance and battery life, perfect for professionals on the go.',
    ),
    Product(
      id: '10',
      title: 'Dell XPS 13',
      imageAsset: 'assets/images/dell_xps_13.png',
      price: 1099.99,
      description: 'The Dell XPS 13 is a sleek and powerful laptop, known for its stunning InfinityEdge display and lightweight design.',
    ),
    Product(
      id: '11',
      title: 'Canon EOS R5',
      imageAsset: 'assets/images/canon_eos_r5.png',
      price: 3899.99,
      description: 'The Canon EOS R5 is a top-tier mirrorless camera with 45 megapixels, 8K video recording, and incredible image stabilization.',
    ),
    Product(
      id: '12',
      title: 'GoPro HERO9',
      imageAsset: 'assets/images/gopro_hero9.png',
      price: 399.99,
      description: 'Capture stunning 5K video and 20MP photos with the GoPro HERO9, featuring HyperSmooth 3.0 stabilization and waterproof design.',
    ),
    Product(
      id: '13',
      title: 'Nintendo Switch',
      imageAsset: 'assets/images/nintendo_switch.png',
      price: 299.99,
      description: 'The Nintendo Switch offers both handheld and TV gaming experiences, making it a versatile console for gamers on the go.',
    ),
    Product(
      id: '14',
      title: 'Dyson V11 Vacuum Cleaner',
      imageAsset: 'assets/images/dyson_v11_vacuum.png',
      price: 599.99,
      description: 'The Dyson V11 cordless vacuum offers powerful suction and intelligent cleaning modes for a deep and thorough clean.',
    ),
    Product(
      id: '15',
      title: 'Fitbit Charge 5',
      imageAsset: 'assets/images/fitbit_charge_5.png',
      price: 179.99,
      description: 'The Fitbit Charge 5 tracks your fitness and health metrics with precision, offering built-in GPS and stress management features.',
    ),
    Product(
      id: '16',
      title: 'Apple AirPods Pro',
      imageAsset: 'assets/images/airpods_pro.png',
      price: 249.99,
      description: 'The AirPods Pro offer active noise cancellation, transparency mode, and a customizable fit for immersive sound.',
    ),
    Product(
      id: '17',
      title: 'Samsung 55" QLED TV',
      imageAsset: 'assets/images/samsung_qled_tv.png',
      price: 1199.99,
      description: 'The Samsung QLED TV offers stunning 4K resolution, vibrant colors, and a sleek design for an immersive home entertainment experience.',
    ),
    Product(
      id: '18',
      title: 'Logitech MX Master 3',
      imageAsset: 'assets/images/logitech_mx_master_3.png',
      price: 99.99,
      description: 'The Logitech MX Master 3 offers precise control, customizability, and ergonomic design, perfect for power users and professionals.',
    ),
    Product(
      id: '19',
      title: 'Jabra Elite 75t',
      imageAsset: 'assets/images/jabra_elite_75t.png',
      price: 179.99,
      description: 'The Jabra Elite 75t wireless earbuds offer excellent sound quality, customizable fit, and noise isolation for on-the-go listening.',
    ),
    Product(
      id: '20',
      title: 'HP Envy 13',
      imageAsset: 'assets/images/hp_envy_13.png',
      price: 899.99,
      description: 'The HP Envy 13 is a stylish, portable laptop with a sleek design, vibrant display, and solid performance for everyday tasks.',
    ),
  ];

  List<Product> _cart = [];
  List<Product> _wishlist = [];

  List<Product> get products => _products;

  List<Product> get cart => _cart;

  List<Product> get wishlist => _wishlist;

  void addToCart(Product product) {
    _cart.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cart.remove(product);
    notifyListeners();
  }

  void removeFromWishlist(Product product) {
  wishlist.remove(product);
  notifyListeners();
}

void addToWishlist(Product product) {
  wishlist.add(product);
  notifyListeners();
}

 void moveAllToCart() {
    _cart.addAll(_wishlist); 
    _wishlist.clear();        
    notifyListeners();        
  }
void removeFromHistory(Product product) {
    _cart.remove(product);
    notifyListeners();  
  }


  void clearHistory() {
    _cart.clear();
    notifyListeners();  
  }

void toggleFavourite(Product product) {
  product.isFavourite = !product.isFavourite;
  if (product.isFavourite) {
    wishlist.add(product);
  } else {
    wishlist.remove(product);
  }
  notifyListeners();  

  Product findById(String id) {
    return _products.firstWhere((product) => product.id == id); 
  }
}

  findById(String productId) {}
}
