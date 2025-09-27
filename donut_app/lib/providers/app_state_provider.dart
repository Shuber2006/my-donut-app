import 'package:flutter/material.dart';

// Modelo para un producto
class Product {
  final String id;
  final String name;
  final String imagePath;
  final double price;
  final String category;
  final String brand;

  Product({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.price,
    required this.category,
    required this.brand,
  });

  Product copyWith({
    String? id,
    String? name,
    String? imagePath,
    double? price,
    String? category,
    String? brand,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      price: price ?? this.price,
      category: category ?? this.category,
      brand: brand ?? this.brand,
    );
  }
}

// Modelo para un item del carrito
class CartItem {
  final String id;
  final String name;
  final String imagePath;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.price,
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;
}

// Provider para gestionar el estado global de la app
class AppStateProvider extends ChangeNotifier {
  // Lista de productos disponibles
  final List<Product> _products = [
    Product(
      id: 'donut_ice_cream',
      name: 'Ice Cream Donut',
      imagePath: 'assets/images/icecream_donut.png',
      price: 36.0,
      category: 'donut',
      brand: 'Dunkins',
    ),
    Product(
      id: 'donut_strawberry',
      name: 'Strawberry Donut',
      imagePath: 'assets/images/strawberry_donut.png',
      price: 45.0,
      category: 'donut',
      brand: 'Dunkins',
    ),
    Product(
      id: 'donut_grape',
      name: 'Grape Donut',
      imagePath: 'assets/images/grape_donut.png',
      price: 84.0,
      category: 'donut',
      brand: 'Dunkins',
    ),
    Product(
      id: 'donut_chocolate',
      name: 'Chocolate Donut',
      imagePath: 'assets/images/chocolate_donut.png',
      price: 95.0,
      category: 'donut',
      brand: 'Dunkins',
    ),
    Product(
      id: 'burger_classic',
      name: 'Classic Burger',
      imagePath: 'assets/images/hamburguer.png',
      price: 80.0,
      category: 'burger',
      brand: 'Burgers',
    ),
    Product(
      id: 'pizza_classic',
      name: 'Pizza',
      imagePath: 'assets/images/pizza.png',
      price: 70.0,
      category: 'pizza',
      brand: 'Pizza',
    ),
  ];

  // Carrito de compras
  final List<CartItem> _cartItems = [];

  // Favoritos
  final Set<String> _favorites = {};

  // Configuración de la app
  bool _darkMode = false;
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'Español';

  // Getters
  List<Product> get products => _products;
  List<CartItem> get cartItems => _cartItems;
  Set<String> get favorites => _favorites;
  bool get darkMode => _darkMode;
  bool get notificationsEnabled => _notificationsEnabled;
  String get selectedLanguage => _selectedLanguage;

  // Obtener productos por categoría
  List<Product> getProductsByCategory(String category) {
    return _products.where((product) => product.category == category).toList();
  }

  // Obtener precio total del carrito
  double get cartTotalPrice {
    return _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  // Obtener cantidad total de items en el carrito
  int get cartItemCount {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  // Métodos del carrito
  void addToCart(Product product, {int quantity = 1}) {
    final existingItemIndex = _cartItems.indexWhere(
      (item) => item.id == product.id,
    );

    if (existingItemIndex != -1) {
      _cartItems[existingItemIndex].quantity += quantity;
    } else {
      _cartItems.add(CartItem(
        id: product.id,
        name: product.name,
        imagePath: product.imagePath,
        price: product.price,
        quantity: quantity,
      ));
    }
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _cartItems.removeWhere((item) => item.id == productId);
    notifyListeners();
  }

  void updateCartItemQuantity(String productId, int quantity) {
    final itemIndex = _cartItems.indexWhere((item) => item.id == productId);
    if (itemIndex != -1) {
      if (quantity <= 0) {
        _cartItems.removeAt(itemIndex);
      } else {
        _cartItems[itemIndex].quantity = quantity;
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // Métodos de favoritos
  void toggleFavorite(String productId) {
    if (_favorites.contains(productId)) {
      _favorites.remove(productId);
    } else {
      _favorites.add(productId);
    }
    notifyListeners();
  }

  bool isFavorite(String productId) {
    return _favorites.contains(productId);
  }

  // Métodos de configuración
  void toggleDarkMode() {
    _darkMode = !_darkMode;
    notifyListeners();
  }

  void toggleNotifications() {
    _notificationsEnabled = !_notificationsEnabled;
    notifyListeners();
  }

  void setLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }

  // Método para buscar productos
  List<Product> searchProducts(String query) {
    if (query.isEmpty) return _products;
    
    return _products.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase()) ||
             product.brand.toLowerCase().contains(query.toLowerCase()) ||
             product.category.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  // Método para obtener productos recomendados
  List<Product> getRecommendedProducts() {
    // Lógica simple: productos más caros como "recomendados"
    final sortedProducts = List<Product>.from(_products);
    sortedProducts.sort((a, b) => b.price.compareTo(a.price));
    return sortedProducts.take(3).toList();
  }
}
