import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemListWidget extends StatefulWidget {
  @override
  State<ItemListWidget> createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<CartItem> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('items').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        final List<DocumentSnapshot> documents = snapshot.data!.docs;
        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final item = documents[index];
            final String name = item['name'] as String;
            final String description = item['description'] as String;
            final double price = (item['price'] ?? 0).toDouble();
            final String imageUrl = item['imageUrl'] as String;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                clipBehavior: Clip.hardEdge,
                child: SizedBox(
                  height: 120,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Placeholder();
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    description,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '\$$price',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8),
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromRGBO(255, 149, 0, 1),
                                      Color.fromRGBO(240, 198, 140, 1),
                                    ],
                                  ),
                                ),
                                child: Material(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      addToCart(item);
                                    },
                                    borderRadius: BorderRadius.circular(10),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Center(
                                        child: Text(
                                          'Add to Cart',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void addToCart(DocumentSnapshot item) {
    final String itemId = item.id;
    final String name = item['name'] as String;
    final double price = (item['price'] ?? 0).toDouble();

    setState(() {
      bool itemExists = false;
      for (var cartItem in cartItems) {
        if (cartItem.itemId == itemId) {
          cartItem.quantity++;
          itemExists = true;
          break;
        }
      }
      if (!itemExists) {
        cartItems.add(CartItem(
          itemId: itemId,
          name: name,
          price: price,
          quantity: 1,
        ));
      }
    });
  }
}

class CartItem {
  final String itemId;
  final String name;
  final double price;
  int quantity;

  CartItem({
    required this.itemId,
    required this.name,
    required this.price,
    this.quantity = 1,
  });
}
