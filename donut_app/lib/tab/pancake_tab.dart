import 'package:flutter/material.dart';

import '../util/donut_tile.dart';
import '../models/cart.dart';

class PancakeTab extends StatelessWidget {
  final List pancakesOnSale = [
    // [flavor, price, color, imageName, brand]
    ["Classic Pancakes", "60", Colors.amber, "assets/images/classic_pancakes.png", "Pancakes"],
    ["Blueberry Pancakes", "75", Colors.blue, "assets/images/Blueberry_pancakes.png", "Pancakes"],
    ["Chocolate Pancakes", "80", Colors.brown, "assets/images/pancakes_chocolate.png", "Pancakes"],
    ["Strawberry Pancakes", "70", Colors.pink, "assets/images/Strawberry_pancakes.png", "Pancakes"],
  ];

  PancakeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: pancakesOnSale.length,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        final item = pancakesOnSale[index];
        final flavor = item[0] as String;
        final priceStr = item[1] as String;
        final color = item[2];
        final image = item[3] as String;
        final brand = item[4] as String;

        return DonutTile(
          donutFlavor: flavor,
          donutPrice: priceStr,
          donutColor: color,
          imageName: image,
          brageName: brand,
          category: 'pancake',
          onAddPressed: () {
            final cart = CartModel();
            final id = 'pancake:$flavor';
            cart.addItem(
              id: id,
              name: '$brand $flavor',
              imagePath: image,
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