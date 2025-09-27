import 'package:flutter/material.dart';
import '../models/cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartModel cart = CartModel();

  @override
  void initState() {
    super.initState();
    cart.addListener(_onCartChanged);
  }

  @override
  void dispose() {
    cart.removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() {
    if (mounted) setState(() {});
  }

  void _handleCheckout() {
    if (cart.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tu carrito está vacío.')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar pago'),
        content: Text('¿Quieres pagar \$${cart.totalPrice.toStringAsFixed(2)}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Cancelar
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              cart.clear(); // Vaciar carrito tras pago
              Navigator.of(context).pop(); // Cerrar diálogo
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('¡Pago realizado con éxito!')),
              );
            },
            child: const Text('Pagar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = cart.items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        actions: [
          if (items.isNotEmpty)
            TextButton(
              onPressed: cart.clear,
              child: const Text(
                'Limpiar',
                style: TextStyle(color: Colors.white),
              ),
            )
        ],
      ),
      body: items.isEmpty
          ? const Center(child: Text('Tu carrito está vacío.'))
          : ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  leading: Image.asset(item.imagePath, width: 48, height: 48),
                  title: Text(item.name),
                  subtitle: Text('Precio: \$${item.price.toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () => cart.removeOne(item.id),
                      ),
                      Text(item.quantity.toString()),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () => cart.addItem(
                          id: item.id,
                          name: item.name,
                          imagePath: item.imagePath,
                          price: item.price,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () => cart.removeItem(item.id),
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Mostrar total
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Total', style: TextStyle(fontSize: 16)),
                Text('\$${cart.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            // Botón pagar
            ElevatedButton(
              onPressed: _handleCheckout,
              child: const Text('Pagar'),
            ),
          ],
        ),
      ),
    );
  }
}
