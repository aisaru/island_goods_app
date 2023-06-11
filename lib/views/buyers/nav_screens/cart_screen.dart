import 'package:flutter/material.dart';
import 'package:island_goods/views/buyers/nav_screens/widgets/item_list_widget.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> cartItems = [];

  double get totalAmount {
    double total = 0;
    for (var cartItem in cartItems) {
      total += cartItem.price * cartItem.quantity;
    }
    return total;
  }

  int get totalQuantity {
    int quantity = 0;
    for (var cartItem in cartItems) {
      quantity += cartItem.quantity;
    }
    return quantity;
  }

  void addToCart(CartItem cartItem) {
    setState(() {
      cartItems.add(cartItem);
    });
  }

  void removeFromCart(CartItem cartItem) {
    setState(() {
      cartItems.remove(cartItem);
    });
  }

  void clearCart() {
    setState(() {
      cartItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
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
