import 'package:flutter/material.dart';
import '../models/cart.dart';

class ProductDetailPage extends StatefulWidget {
  final String name;
  final String imagePath;
  final double price;
  final String brand;
  final Color productColor;
  final String category;

  const ProductDetailPage({
    super.key,
    required this.name,
    required this.imagePath,
    required this.price,
    required this.brand,
    required this.productColor,
    required this.category,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;
  final CartModel cart = CartModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey[800],
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: Colors.grey[800],
            ),
            onPressed: () {
              // TODO: Implementar favoritos
            },
          ),
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.grey[800],
            ),
            onPressed: () {
              // TODO: Implementar compartir
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del producto
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: widget.productColor.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Image.asset(
                  widget.imagePath,
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Información del producto
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Marca
                  Text(
                    widget.brand,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Nombre del producto
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Precio
                  Row(
                    children: [
                      Text(
                        '\$${widget.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: widget.productColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'En Stock',
                          style: TextStyle(
                            color: Colors.green[800],
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Descripción
                  Text(
                    'Descripción',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    _getProductDescription(widget.name, widget.category),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Información nutricional
                  Text(
                    'Información Nutricional',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  _buildNutritionInfo(),
                  
                  const SizedBox(height: 24),
                  
                  // Controles de cantidad
                  Text(
                    'Cantidad',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: quantity > 1 ? () {
                                setState(() {
                                  quantity--;
                                });
                              } : null,
                              icon: Icon(
                                Icons.remove,
                                color: quantity > 1 ? Colors.grey[800] : Colors.grey[400],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                quantity.toString(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
      
      // Botón de agregar al carrito
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Precio total
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '\$${(widget.price * quantity).toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: widget.productColor,
                    ),
                  ),
                ],
              ),
            ),
            
            // Botón agregar al carrito
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {
                  for (int i = 0; i < quantity; i++) {
                    cart.addItem(
                      id: '${widget.category}:${widget.name}',
                      name: '${widget.brand} ${widget.name}',
                      imagePath: widget.imagePath,
                      price: widget.price,
                    );
                  }
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$quantity ${widget.name} agregado(s) al carrito'),
                      backgroundColor: widget.productColor,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.productColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Agregar al Carrito',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          _buildNutritionRow('Calorías', '250 kcal'),
          const Divider(),
          _buildNutritionRow('Grasas', '12g'),
          const Divider(),
          _buildNutritionRow('Carbohidratos', '35g'),
          const Divider(),
          _buildNutritionRow('Proteínas', '4g'),
        ],
      ),
    );
  }

  Widget _buildNutritionRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  String _getProductDescription(String name, String category) {
    switch (category.toLowerCase()) {
      case 'donut':
        return 'Delicioso donut artesanal con ingredientes frescos y sabor auténtico. Perfecto para acompañar tu café de la mañana o como postre especial.';
      case 'burger':
        return 'Hamburguesa gourmet preparada con carne fresca, vegetales crujientes y salsas especiales. Una experiencia de sabor única.';
      case 'pizza':
        return 'Pizza italiana tradicional con ingredientes premium y masa artesanal. Horneada al horno de leña para el sabor auténtico.';
      case 'smoothie':
        return 'Smoothie natural preparado con frutas frescas y ingredientes orgánicos. Refrescante y nutritivo, perfecto para cualquier momento del día.';
      case 'pancake':
        return 'Pancakes esponjosos preparados con ingredientes frescos y servidos con sirope de arce. El desayuno perfecto para empezar el día.';
      default:
        return 'Producto delicioso preparado con ingredientes frescos y de la más alta calidad. Una experiencia gastronómica única.';
    }
  }
}


