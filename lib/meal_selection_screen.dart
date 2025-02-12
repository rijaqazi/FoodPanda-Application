import 'package:flutter/material.dart';

class Meal {
  final String name;
  final String description;
  final String image;
  final double price;

  Meal({
    required this.name,
    required this.description,
    required this.image,
    required this.price,
  });
}


List<Meal> meals = [
  Meal(
    name: 'Pizza',
    description:
        'Pizza is a savory dish of Italian origin consisting of a flat, round base of dough baked with a topping of tomatoes and cheese, typically with added meat, vegetables, or other ingredients.',
    image: 'assets/images/pizza.jpg',
    price: 999.00,
  ),
  Meal(
    name: 'Burger',
    description:
        'A burger is a sandwich consisting of fillings, typically a patty of ground meat, placed inside a sliced bread roll or bun.',
    image: 'assets/images/burger.jpg',
    price: 699.00,
  ),
  Meal(
    name: 'Chocolate Cake',
    description:
        'Chocolate cake is a rich and decadent dessert made with cocoa powder or melted chocolate.',
    image: 'assets/images/cake.jpg',
    price: 599.00,
  ),
  Meal(
    name: 'Chicken Nuggets',
    description:
        'Chicken nuggets are bite-sized pieces of chicken meat that are breaded or battered, then fried or baked.',
    image: 'assets/images/nuggets.jpg',
    price: 499.00,
  ),
  Meal(
    name: 'French Fries',
    description:
        'French fries are thin slices of potato that are deep-fried until crispy and golden.',
    image: 'assets/images/fries.jpg',
    price: 199.00,
  ),
  Meal(
    name: 'Hotpot',
    description:
        'Hotpot is a communal Chinese cooking experience where diners simmer various ingredients like meat, seafood, vegetables, and noodles in a shared pot of flavorful boiling broth.',
    image: 'assets/images/hotpot.jpg',
    price: 1299.00,
  ),
  Meal(
    name: 'Butter Chicken',
    description:
        'Butter chicken, or murgh makhani, is a popular Indian dish made with chicken cooked in a mildly spiced tomato-based curry.',
    image: 'assets/images/butterchicken.jpg',
    price: 1049.00,
  ),
];


void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Meal> _cart = [];

  void addToCart(Meal meal) {
    setState(() {
      _cart.add(meal);
    });
  }

  void removeFromCart(Meal meal) {
    setState(() {
      _cart.remove(meal);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Selector',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MealSelectionScreen(
        cart: _cart,
        addToCart: addToCart,
        removeFromCart: removeFromCart,
      ),
    );
  }
}


class MealSelectionScreen extends StatelessWidget {
  final List<Meal> cart;
  final Function(Meal) addToCart;
  final Function(Meal) removeFromCart;

  const MealSelectionScreen({
    required this.cart,
    required this.addToCart,
    required this.removeFromCart,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Meal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CartScreen(cart: cart, removeFromCart: removeFromCart),
                ),
              );
            },
          ),
        ],
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
          itemCount: meals.length,
          itemBuilder: (context, index) {
            final meal = meals[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MealDetailScreen(
                      meal: meal,
                      addToCart: addToCart,
                    ),
                  ),
                );
              },
              child: MealCard(meal: meal),
            );
          },
        ),
      ),
    );
  }
}


class MealCard extends StatelessWidget {
  final Meal meal;

  const MealCard({required this.meal, super.key});

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
              meal.image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error, size: 50, color: Colors.red);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  meal.name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'Rs${meal.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class MealDetailScreen extends StatelessWidget {
  final Meal meal;
  final Function(Meal) addToCart;

  const MealDetailScreen({
    required this.meal,
    required this.addToCart,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  meal.image,
                  fit: BoxFit.cover,
                  height: 250,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error, size: 50, color: Colors.red);
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                meal.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Divider(color: Colors.grey[400], thickness: 1),
              const SizedBox(height: 12),
              Text(
                meal.description,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Price: Rs${meal.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  addToCart(meal);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${meal.name} added to cart!'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Cart screen
class CartScreen extends StatelessWidget {
  final List<Meal> cart;
  final Function(Meal) removeFromCart;

  const CartScreen({
    required this.cart,
    required this.removeFromCart,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: cart.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final meal = cart[index];
                return ListTile(
                  leading: Image.asset(
                    meal.image,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(meal.name),
                  subtitle: Text('Rs${meal.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      removeFromCart(meal);
                    },
                  ),
                );
              },
            ),
    );
  }
}
