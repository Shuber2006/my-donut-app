import 'package:flutter/material.dart';

import '../util/donut_tile.dart';
import '../models/cart.dart';

class BurgerTab extends StatelessWidget {
  final List burgersOnSale = [
    // [flavor, price, color, imageName, brand]
    ["Classic Burger", "80", Colors.brown, "assets/images/hamburguer.png", "Burgers"],
    ["The Ultimate Burger Combo", "95", Colors.orange, "assets/images/hamburger_max.png", "Burgers"],
    ["Burger Break", "120", Colors.deepOrange, "assets/images/burger.png", "Burgers"],
    ["Fries and Burger", "90", Colors.green, "assets/images/fast-food.png", "Burgers"],
  ];

  BurgerTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: burgersOnSale.length,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        final item = burgersOnSale[index];
        final flavor = item[0] as String;
        final priceStr = item[1] as String;
        final color = item[2];
        final image = item[3] as String; // empty for now
        final brand = item[4] as String;

        return DonutTile(
          donutFlavor: flavor,
          donutPrice: priceStr,
          donutColor: color,
          imageName: image,
          brageName: brand,
          category: 'burger',
          onAddPressed: () {
            final cart = CartModel();
            final id = 'burger:$flavor';
            cart.addItem(
              id: id,
              name: '$brand $flavor',
              imagePath: image.isEmpty ? 'assets/images/placeholder.png' : image,
              price: double.tryParse(priceStr) ?? 0,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Añadido: $flavor'),
                duration: const Duration(milliseconds: 900),
              ),
            );
          },
        );
      },
    );
  }
}