import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String name;
  final double price;
  final String description;
  final String image;

  Product({
    required this.name,
    required this.price,
    required this.description,
    required this.image,
  });
}


List<Product> products = [
  Product(name: 'Milk', price: 300.0, description: 'Fresh milk.', image: 'assets/images/milk.jpg'),
  Product(name: 'Bread', price: 200.0, description: 'Whole grain bread.', image: 'assets/images/bread.jpg'),
  Product(name: 'Eggs', price: 150.0, description: 'Farm fresh eggs.', image: 'assets/images/eggs.jpg'),
  Product(name: 'Doritos', price: 1500.0, description: 'Nacho cheese flavored.', image: 'assets/images/doritos.jpg'),
  Product(name: 'Ferrero Rocher', price: 999.0, description: 'Chocolate with hazelnuts.', image: 'assets/images/ferrero.jpg'),
  Product(name: 'Orange Juice', price: 150.0, description: 'Freshly squeezed orange juice.', image: 'assets/images/juice.jpg'),
  Product(name: 'Nutella', price: 4000.0, description: 'Hazelnut spread.', image: 'assets/images/nutella.jpg'),
  Product(name: 'Potato', price: 100.0, description: 'Fresh potatoes.', image: 'assets/images/potato.jpg'),
  Product(name: 'Rice', price: 150.0, description: 'White rice.', image: 'assets/images/rice.jpg'),
];

// Cart class
class Cart {
  final List<Product> _items = [];

  List<Product> get items => _items;

  double get totalPrice => _items.fold(0, (sum, item) => sum + item.price);

  void addToCart(Product product) {
    _items.add(product);
  }

  void removeFromCart(Product product) {
    _items.remove(product);
  }
}

class ProductSelectionScreen extends StatelessWidget {
  final Cart cart;

  const ProductSelectionScreen({required this.cart, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,  
            crossAxisSpacing: 8.0,  
            mainAxisSpacing: 8.0,   
            childAspectRatio: 0.8,  
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(
              product: product,
             onAddToCart: () async {
                cart.addToCart(product);
                  await addToCartFirebase(product, 1); 
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} added to cart!'),
                            duration: const Duration(seconds: 2),
                   ),
                   );
                  },

            );
          },
        ),
      ),
    );
  }
}


class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ProductCard({required this.product, required this.onAddToCart, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(4.0),  
      elevation: 2.0,  
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.asset(
              product.image,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 16.0, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '₨${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14.0),  
                ),
                const SizedBox(height: 6),
                Center(
                  child: ElevatedButton(
                    onPressed: onAddToCart,
                    child: const Text('Add To Cart'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> addToCartFirebase(Product product, int quantity) async {
  final cartItem = {
    'name': product.name,
    'price': product.price,
    'description': product.description,
    'image': product.image,
    'quantity': quantity,
    'userId': 'user123', // Add userId if you have user authentication
  };

  await FirebaseFirestore.instance.collection('cartItems').add(cartItem);
}
