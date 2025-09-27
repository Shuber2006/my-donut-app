import 'package:flutter/material.dart';

import '../util/donut_tile.dart';
import '../models/cart.dart';

class DonutTab extends StatelessWidget {
  // ✅ Mantener como final para respetar inmutabilidad del StatelessWidget
  final List donutsOnSale = [
    // [donutFlavor, donutPrice, donutColor, imageName, brand]
    ["Ice Cream Donut", "36", Colors.blue, "assets/images/icecream_donut.png", "Dunkins"],
    ["Strawberry Donut", "45", Colors.red, "assets/images/strawberry_donut.png", "Dunkins"],
    ["Grape Donut", "84", Colors.purple, "assets/images/grape_donut.png", "Dunkins"],
    ["Chocolate Donut", "95", Colors.brown, "assets/images/chocolate_donut.png", "Dunkins"],
  ];

  // ✅ Constructor SIN 'const'
  DonutTab({Key? key}) : super(key: key);

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
              final donut = donutsOnSale[index];
              final flavor = donut[0] as String;
              final priceStr = donut[1] as String;
              final color = donut[2];
              final image = donut[3] as String;
              final brand = donut[4] as String;

              return DonutTile(
                donutFlavor: flavor,
                donutPrice: priceStr,
                donutColor: color,
                imageName: image,
                brageName: brand,
                category: 'donut',
                onAddPressed: () {
                  final cart = CartModel();
                  final id = 'donut:$flavor';
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
