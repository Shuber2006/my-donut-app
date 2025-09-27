import 'package:flutter/material.dart';
import '../pages/product_detail_page.dart';

class DonutTile extends StatelessWidget {
  final String donutFlavor;
  final String donutPrice;
  final donutColor;
  final String imageName;
  final String brageName;
  final VoidCallback? onAddPressed;
  final String category;

  final double borderRadius = 12;

  const DonutTile({
    super.key,
    required this.donutFlavor,
    required this.donutPrice,
    required this.donutColor,
    required this.imageName,
    required this.brageName,
    required this.category,
    this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    Color resolveSwatchShade(dynamic swatch, int shade, {double fallbackOpacity = 0.12}) {
      if (swatch is MaterialColor) {
        return swatch[shade] ?? swatch;
      }
      if (swatch is MaterialAccentColor) {
        final int mapped = shade == 50 ? 100 : (shade == 800 ? 700 : 200);
        return swatch[mapped] ?? swatch;
      }
      final Color base = (swatch is Color) ? swatch : Colors.grey;
      return base.withOpacity(fallbackOpacity);
    }

    final Color tileBg = resolveSwatchShade(donutColor, 50, fallbackOpacity: 0.10);
    final Color priceBg = resolveSwatchShade(donutColor, 100, fallbackOpacity: 0.18);
    final Color textStrong = resolveSwatchShade(donutColor, 800, fallbackOpacity: 1.0);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(
                name: donutFlavor,
                imagePath: imageName,
                price: double.tryParse(donutPrice) ?? 0,
                brand: brageName,
                productColor: donutColor,
                category: category,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: tileBg,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Column(
          children: [
            // price
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: priceBg,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius),
                    ),
                  ),
                  padding: EdgeInsets.all(12),
                  child: Text(
                    '\$$donutPrice',
                    style: TextStyle(
                      color: textStrong,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),

            // donut picture
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 36.0, vertical: 16),
              child: (imageName.isEmpty)
                  ? const SizedBox(height: 100)
                  : Image.asset(imageName),
            ),

            // donut flavor
            Text(
              donutFlavor,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              brageName,
              style: TextStyle(color: Colors.grey[600]),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // love icon
                  Icon(
                    Icons.favorite,
                    color: Colors.pink[400],
                  ),

                  // plus button
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: onAddPressed,
                    child: Icon(
                      Icons.add,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        ),
      ),
    );
  }
}