// import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';

class AddedItemsScreen extends StatefulWidget {
  const AddedItemsScreen({Key? key}) : super(key: key);

  @override
  State<AddedItemsScreen> createState() => _AddedItemsScreenState();
}

class _AddedItemsScreenState extends State<AddedItemsScreen> {
  final TextEditingController searchController = TextEditingController();
  List<QueryDocumentSnapshot> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = [];
  }

  Future<void> searchItems(String searchQuery) async {
    final CollectionReference itemsRef =
        FirebaseFirestore.instance.collection('items');

    final QuerySnapshot querySnapshot =
        await itemsRef.where('name', isEqualTo: searchQuery).get();

    setState(() {
      filteredItems = querySnapshot.docs;
    });
  }

  void clearSearch() {
    setState(() {
      filteredItems = [];
      searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Added Items'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Search Items'),
                    content: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        hintText: 'Enter item name',
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          clearSearch();
                          Navigator.pop(context);
                        },
                        child: const Text('Clear'),
                      ),
                      TextButton(
                        onPressed: () {
                          final String searchQuery = searchController.text;
                          searchItems(searchQuery);
                          Navigator.pop(context);
                        },
                        child: const Text('Search'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: filteredItems.isNotEmpty
          ? ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final itemSnapshot = filteredItems[index];
                final itemData = itemSnapshot.data() as Map<String, dynamic>;

                return ListTile(
                  title: Text(itemData['name']),
                  subtitle: Text(itemData['description']),
                  trailing: Text('\$${itemData['price']}'),
                  leading: itemData['imageUrl'] != null
                      ? Image.network(itemData['imageUrl'])
                      : null,
                  onTap: () {
                    // Handle item tap
                  },
                );
              },
            )
          : Center(
              child: Text(
                'No items found.',
                style: TextStyle(fontSize: 18),
              ),
            ),
    );
  }
}
