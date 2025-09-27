import 'package:flutter/material.dart';
import '../pages/cart_page.dart';
import '../tab/donut_tab.dart';
import '../tab/burger_tab.dart';
import '../tab/pizza_tab.dart';
import '../tab/smoothie_tab.dart';
import '../tab/pancake_tab.dart';
import '../pages/settings_page.dart';
import '../pages/favorites_page.dart';

class AppNavigationDrawer extends StatelessWidget {
  const AppNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header del drawer
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[400]!, Colors.purple[400]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.local_dining,
                  size: 50,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Text(
                  'Donut App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Deliciosas donas y más',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Opciones del menú
          _buildDrawerItem(
            context,
            icon: Icons.home,
            title: 'Inicio',
            onTap: () {
              Navigator.pop(context);
              // Ya estamos en home, no hacer nada
            },
          ),
          
          _buildDrawerItem(
            context,
            icon: Icons.local_dining,
            title: 'Donas',
            onTap: () {
              Navigator.pop(context);
              _navigateToCategory(context, 'donuts');
            },
          ),
          
          _buildDrawerItem(
            context,
            icon: Icons.lunch_dining,
            title: 'Hamburguesas',
            onTap: () {
              Navigator.pop(context);
              _navigateToCategory(context, 'burgers');
            },
          ),
          
          _buildDrawerItem(
            context,
            icon: Icons.local_pizza,
            title: 'Pizzas',
            onTap: () {
              Navigator.pop(context);
              _navigateToCategory(context, 'pizzas');
            },
          ),
          
          _buildDrawerItem(
            context,
            icon: Icons.local_drink,
            title: 'Smoothies',
            onTap: () {
              Navigator.pop(context);
              _navigateToCategory(context, 'smoothies');
            },
          ),
          
          _buildDrawerItem(
            context,
            icon: Icons.cake,
            title: 'Pancakes',
            onTap: () {
              Navigator.pop(context);
              _navigateToCategory(context, 'pancakes');
            },
          ),
          
          const Divider(),
          
          _buildDrawerItem(
            context,
            icon: Icons.shopping_cart,
            title: 'Mi Carrito',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartPage(),
                ),
              );
            },
          ),
          
          _buildDrawerItem(
            context,
            icon: Icons.favorite,
            title: 'Favoritos',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesPage(),
                ),
              );
            },
          ),
          
          _buildDrawerItem(
            context,
            icon: Icons.history,
            title: 'Historial',
            onTap: () {
              Navigator.pop(context);
              // TODO: Implementar página de historial
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Historial próximamente'),
                ),
              );
            },
          ),
          
          const Divider(),
          
          _buildDrawerItem(
            context,
            icon: Icons.settings,
            title: 'Configuración',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
          
          _buildDrawerItem(
            context,
            icon: Icons.help,
            title: 'Ayuda',
            onTap: () {
              Navigator.pop(context);
              // TODO: Implementar página de ayuda
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Ayuda próximamente'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  void _navigateToCategory(BuildContext context, String category) {
    // Esta función se puede usar para navegar a categorías específicas
    // Por ahora solo mostramos un mensaje
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Navegando a $category'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
