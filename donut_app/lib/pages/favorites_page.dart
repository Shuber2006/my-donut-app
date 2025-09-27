import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../pages/product_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Favoritos'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Consumer<AppStateProvider>(
            builder: (context, appState, child) {
              return IconButton(
                icon: Icon(
                  appState.darkMode ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: () {
                  appState.toggleDarkMode();
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<AppStateProvider>(
        builder: (context, appState, child) {
          final favoriteProductIds = appState.favorites;
          final favoriteProducts = appState.products
              .where((product) => favoriteProductIds.contains(product.id))
              .toList();

          if (favoriteProducts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 100,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No tienes favoritos aún',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Agrega productos a tus favoritos tocando el corazón',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favoriteProducts.length,
            itemBuilder: (context, index) {
              final product = favoriteProducts[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                          name: product.name,
                          imagePath: product.imagePath,
                          price: product.price,
                          brand: product.brand,
                          productColor: _getCategoryColor(product.category),
                          category: product.category,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Imagen del producto
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: _getCategoryColor(product.category).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              product.imagePath,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        
                        const SizedBox(width: 16),
                        
                        // Información del producto
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                product.brand,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: _getCategoryColor(product.category),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Botones de acción
                        Column(
                          children: [
                            // Botón de favorito
                            IconButton(
                              onPressed: () {
                                appState.toggleFavorite(product.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      appState.isFavorite(product.id)
                                          ? 'Agregado a favoritos'
                                          : 'Removido de favoritos',
                                    ),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                              icon: Icon(
                                appState.isFavorite(product.id)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                              ),
                            ),
                            
                            // Botón de agregar al carrito
                            Container(
                              decoration: BoxDecoration(
                                color: _getCategoryColor(product.category),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                onPressed: () {
                                  appState.addToCart(product);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${product.name} agregado al carrito'),
                                      backgroundColor: _getCategoryColor(product.category),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      
      // Bottom bar con información del estado
      bottomNavigationBar: Consumer<AppStateProvider>(
        builder: (context, appState, child) {
          return Container(
            padding: const EdgeInsets.all(16),
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Información del carrito
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.blue[600],
                    ),
                    Text(
                      '${appState.cartItemCount} items',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue[600],
                      ),
                    ),
                  ],
                ),
                
                // Información de favoritos
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.red[600],
                    ),
                    Text(
                      '${appState.favorites.length} favoritos',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red[600],
                      ),
                    ),
                  ],
                ),
                
                // Información del modo oscuro
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      appState.darkMode ? Icons.dark_mode : Icons.light_mode,
                      color: Colors.orange[600],
                    ),
                    Text(
                      appState.darkMode ? 'Oscuro' : 'Claro',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.orange[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'donut':
        return Colors.pink;
      case 'burger':
        return Colors.brown;
      case 'pizza':
        return Colors.red;
      case 'smoothie':
        return Colors.green;
      case 'pancake':
        return Colors.amber;
      default:
        return Colors.blue;
    }
  }
}



