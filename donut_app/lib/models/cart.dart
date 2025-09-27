import 'package:flutter/foundation.dart';

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
}

class CartModel extends ChangeNotifier {
  static final CartModel _instance = CartModel._internal();
  factory CartModel() => _instance;
  CartModel._internal();

  final Map<String, CartItem> _idToItem = {};

  List<CartItem> get items => _idToItem.values.toList(growable: false);

  void addItem({
    required String id,
    required String name,
    required String imagePath,
    required double price,
  }) {
    if (_idToItem.containsKey(id)) {
      _idToItem[id]!.quantity += 1;
    } else {
      _idToItem[id] = CartItem(
        id: id,
        name: name,
        imagePath: imagePath,
        price: price,
        quantity: 1,
      );
    }
    notifyListeners();
  }

  void removeOne(String id) {
    final item = _idToItem[id];
    if (item == null) return;
    if (item.quantity > 1) {
      item.quantity -= 1;
    } else {
      _idToItem.remove(id);
    }
    notifyListeners();
  }

  void removeItem(String id) {
    if (_idToItem.remove(id) != null) {
      notifyListeners();
    }
  }

  void clear() {
    _idToItem.clear();
    notifyListeners();
  }

  int get totalItems => _idToItem.values.fold(0, (sum, it) => sum + it.quantity);

  double get totalPrice => _idToItem.values
      .fold(0.0, (sum, it) => sum + it.price * it.quantity);
}


