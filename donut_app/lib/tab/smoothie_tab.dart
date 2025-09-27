import 'package:flutter/material.dart';

import '../util/donut_tile.dart';
import '../models/cart.dart';

class SmoothieTab extends StatelessWidget {
  // ✅ Mantener como final para respetar inmutabilidad del StatelessWidget
  final List donutsOnSale = [
    // [donutFlavor, donutPrice, donutColor, imageName]
    ["Banana Smoothie", "90", Colors.yellow, "assets/images/banana_smoothie.png","Smoosthies"],
    ["Coconut", "120", Colors.greenAccent, "assets/images/coconut.png","Smoosthies"],
    ["smoothie", "70", Colors.pink, "assets/images/smoothie.png","Smoosthies"],
    ["Smoothie Strawberry", "70", Colors.blueAccent, "assets/images/smoothie_strawberry.png","Smoosthies"],
  ];

  // ✅ Constructor SIN 'const'
  SmoothieTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: donutsOnSale.length,
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        final item = donutsOnSale[index];
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
          category: 'smoothie',
          onAddPressed: () {
            final cart = CartModel();
            final id = 'smoothie:$flavor';
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
