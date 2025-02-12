import 'package:flutter/material.dart';
import 'package:shopping_cart/favorites.dart';
import 'package:shopping_cart/feedback.dart';
import 'package:shopping_cart/help_centre.dart';
import 'package:shopping_cart/meal_selection_screen.dart'; 
import 'package:shopping_cart/order.dart';
import 'package:shopping_cart/place_order.dart';
import 'package:shopping_cart/product.dart';
import 'package:shopping_cart/profile.dart';
import 'package:shopping_cart/voucher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Cart _cart = Cart();
  final List<Product> _favorites = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Panda Mart', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen(cart: _cart)),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.pink),
              child: const Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favorites'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FavoritesScreen(favorites: _favorites)),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text('Order'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const order()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen(
                            name: " ",
                            email: " ",
                            message: " ",
                          )),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.card_giftcard),
              title: const Text('Voucher'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const voucher()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help Centre'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpCentre()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text('Feedback'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Feed_back()),
                );
              },
            ),
          ],
        ),
      ),                                                                                              
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MealSelectionScreen(cart: const [], addToCart: (Meal ) {  }, removeFromCart: (Meal ) {  },)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.pink,
                    ),
                    child: const Text('Meals'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ProductListScreen(
              products: products,
              cart: _cart,
              favorites: _favorites,
              onAddToCart: (product) {
                setState(() {
                  _cart.addToCart(product);
                });
              },
              onFavorite: (product) {
                setState(() {
                  if (_favorites.contains(product)) {
                    _favorites.remove(product); 
                   
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} removed from favorites!'),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    _favorites.add(product); 
                 
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} added to favorites!'),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
class ProductListScreen extends StatelessWidget {
  final List<Product> products;
  final Cart cart;
  final List<Product> favorites;
  final Function(Product) onAddToCart;
  final Function(Product) onFavorite;

  const ProductListScreen({
    required this.products,
    required this.cart,
    required this.favorites,
    required this.onAddToCart,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, 
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.5, 
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final isFavorite = favorites.contains(product); 

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Stack(
            children: [
           
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png', 
                  image: product.image,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  fadeInDuration: const Duration(milliseconds: 300),
                  fadeInCurve: Curves.easeIn,
                 
                  placeholderErrorBuilder: (context, error, stackTrace) =>
                      const Center(child: CircularProgressIndicator()), 
                ),
              ),
              
              Positioned(
                bottom: 10.0,
                left: 10.0,
                child: Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, 
                  ),
                ),
              ),
              
              Positioned(
                bottom: 5.0,
                right: 5.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5), 
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Colors.white, 
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₨${product.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.white, 
                        ),
                        onPressed: () => onFavorite(product),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: Colors.white, 
                        ),
                        onPressed: () => onAddToCart(product),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CartScreen extends StatefulWidget {
  final Cart cart;

  const CartScreen({required this.cart});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: widget.cart.items.isEmpty
            ? const Center(
                child: Text('Cart Is Empty',
                    style: TextStyle(fontSize: 18, color: Colors.pink)),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.cart.items.length,
                      itemBuilder: (context, index) {
                        final product = widget.cart.items[index];
                        return ListTile(
                          title: Text(product.name),
                          subtitle: Text('₨${product.price.toStringAsFixed(2)}'),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                widget.cart.removeFromCart(product);
                              });
                            },
                            icon: const Icon(Icons.remove),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.black87,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: ₨${widget.cart.totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        ElevatedButton.icon(
                          onPressed: widget.cart.items.isEmpty
                              ? null
                              : () => _navigateToPlaceOrderScreen(context),
                          icon: const Icon(Icons.shopping_cart_checkout),
                          label: const Text('Place Order'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void _navigateToPlaceOrderScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceOrderScreen(cart: widget.cart),
      ),
    );
  }
}