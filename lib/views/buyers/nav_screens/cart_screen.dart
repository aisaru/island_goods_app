import 'package:flutter/material.dart';
import 'package:island_goods/views/buyers/nav_screens/providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    double totalAmount = 0;
    int totalQuantity = 0;

    for (var cartItem in cartItems) {
      totalAmount += cartItem.price * cartItem.quantity;
      totalQuantity += cartItem.quantity;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return ListTile(
                  title: Text(cartItem.name),
                  subtitle: Text('Quantity: ${cartItem.quantity}'),
                  trailing: Text(
                    'Price: \$${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}',
                  ),
                );
              },
            ),
          ),
          ListTile(
            title: Text('Total Quantity: $totalQuantity'),
            subtitle: Text('Total Amount: \$${totalAmount.toStringAsFixed(2)}'),
          ),
          // Add checkout button or any other UI components here
        ],
      ),
    );
  }
}

class Provider {}
