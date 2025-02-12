import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_cart/product.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Product> favorites;

  const FavoritesScreen({required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.pink,
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text('No Favorites Yet',
                  style: TextStyle(fontSize: 18, color: Colors.pink)),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];
                return ListTile(
                  leading: Image.asset(
                    product.image,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.name),
                  subtitle: Text('₨${product.price.toStringAsFixed(2)}'),
                );
              },
            ),
    );
  }
}


Future<void> addFavoriteToFirebase(Product product) async {
  final firestore = FirebaseFirestore.instance;
  try {
    await firestore.collection('favorites').add({
      'name': product.name,
      'price': product.price,
      'image': product.image,
    });
    print('Favorite added to Firebase');
  } catch (e) {
    print('Error adding favorite to Firebase: $e');
  }
}


Future<void> removeFavoriteFromFirebase(Product product) async {
  final firestore = FirebaseFirestore.instance;
  try {
    final snapshot = await firestore
        .collection('favorites')
        .where('name', isEqualTo: product.name)
        .get();

    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
    print('Favorite removed from Firebase');
  } catch (e) {
    print('Error removing favorite from Firebase: $e');
  }
}
