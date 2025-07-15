import 'package:flutter/material.dart';

void main() {
  runApp(const EdenCartVegApp());
}

class EdenCartVegApp extends StatelessWidget {
  const EdenCartVegApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EdenCart Veg',
      theme: ThemeData(
        primaryColor: const Color(0xFF43A047),
        scaffoldBackgroundColor: const Color(0xFFF1F8E9),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF43A047),
          foregroundColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Welcome to EdenCart',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                  );
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> categories = [
    {
      "title": "Mushroom",
      "image": "https://images.unsplash.com/photo-1604908177225-c472df07c4c5",
      "price": "Rs 80 per packet",
      "desc": "Fresh button mushrooms for cooking delicious meals."
    },
    {
      "title": "Brinjal",
      "image": "https://images.unsplash.com/photo-1627308595229-7830a5c91f9f",
      "price": "Rs 30 per kg",
      "desc": "Organic brinjals freshly harvested from the farm."
    },
    {
      "title": "Banana",
      "image": "https://images.unsplash.com/photo-1574226516831-e1dff420e40d",
      "price": "Rs 50 per dozen",
      "desc": "Ripe bananas rich in potassium and taste."
    },
    {
      "title": "Tomato",
      "image": "https://images.unsplash.com/photo-1582515073490-39981397c445",
      "price": "Rs 25 per kg",
      "desc": "Juicy red tomatoes, perfect for salads and curries."
    },
    {
      "title": "Cabbage",
      "image": "https://images.unsplash.com/photo-1615485296731-5c83c1b3e9e9",
      "price": "Rs 35 per piece",
      "desc": "Healthy cabbage full of fiber and nutrients."
    },
    {
      "title": "Potato",
      "image": "https://images.unsplash.com/photo-1582515073490-39981397c445",
      "price": "Rs 20 per kg",
      "desc": "Staple potatoes ideal for any dish."
    },
    {
      "title": "Carrot",
      "image": "https://images.unsplash.com/photo-1560807707-8cc77767d783",
      "price": "Rs 40 per kg",
      "desc": "Crunchy carrots rich in Vitamin A."
    },
  ];

  final List<Map<String, String>> cart = [];

  void addToCart(Map<String, String> item) {
    setState(() {
      cart.add(item);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item['title']} added to cart')),
    );
  }

  void openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CartPage(cartItems: cart),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EdenCart - Vegetarian Fresh Market'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: openCart, icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shop by Category',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) {
                  final item = categories[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: Image.network(
                            item['image']!,
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item['title']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item['price']!,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                          child: Text(
                            item['desc']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => addToCart(item),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF43A047),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text("Add to Cart"),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF43A047),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Map<String, String>> cartItems;
  const CartPage({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Cart")),
      body: cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return ListTile(
                        leading: Image.network(item['image']!, width: 50, height: 50, fit: BoxFit.cover),
                        title: Text(item['title']!),
                        subtitle: Text(item['price']!),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF43A047),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Order Placed"),
                          content: const Text("Thank you for shopping with EdenCart!"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            )
                          ],
                        ),
                      );
                    },
                    child: const Text("Checkout", style: TextStyle(fontSize: 16)),
                  ),
                )
              ],
            ),
    );
  }
}
