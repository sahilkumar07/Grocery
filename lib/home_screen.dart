import 'package:flutter/material.dart';
import 'package:grocery/products_details.dart';
import 'package:grocery/product_item.dart';
import 'package:grocery/signup_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Broccoli',
      'price': 150.0,
      'image': 'assets/images/10.jpg',
      'description': 'Fresh and healthy broccoli get at just 150 per kg.',
    },
    {
      'name': 'Banana',
      'price': 60.0,
      'image': 'assets/images/4.png',
      'description': 'Fresh and sweet Bananas get at just 60 per dozen.',
    },
    {
      'name': 'Potato',
      'price': 30.0,
      'image': 'assets/images/11.jpg',
      'description': 'Fresh and healthy potataoes get at 30 per kg.',
    },
    {
      'name': 'Apple',
      'price': 200.0,
      'image': 'assets/images/3.png',
      'description': 'Fresh and healthy apples get at 200 per kg.',
    },
    {
      'name': 'Brinjal',
      'price': 40.0,
      'image': 'assets/images/8.jpg',
      'description': 'Fresh brinjals get at 40 per kg.',
    },
    {
      'name': 'Orange',
      'price': 120.0,
      'image': 'assets/images/7.jpg',
      'description': 'Fresh oranges get at 120 per kg.',
    },
    {
      'name': 'Grapes',
      'price': 100.0,
      'image': 'assets/images/5.jpg',
      'description': 'Fresh grapes get at 120 per kg.',
    },
    {
      'name': 'Tomato',
      'price': 100.0,
      'image': 'assets/images/12.jpg',
      'description': 'Fresh tomatoes get at just 100 per kg .',
    },
    {
      'name': 'Soft Drinks',
      'price': 60.0,
      'image': 'assets/images/14.jpeg',
      'description': 'Sting,ThumpsUp, Coca Cola, Fanta, Sprite - 500ml.',
    },
  ];

  final Map<String, int> cartItems = {};
  final TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products
        .where((product) =>
            product['name'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text('Products'),
        backgroundColor: Color.fromRGBO(48, 186, 220, 1),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Cart Items'),
                  content: cartItems.isEmpty
                      ? Text('No items in the cart.')
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: cartItems.entries
                              .map((entry) =>
                                  Text('${entry.key} x${entry.value}'))
                              .toList(),
                        ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Search by product name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (screenWidth < 600) ? 2 : 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.7,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            product: filteredProducts[index],
                            onAddToCart: (int quantity) {
                              setState(() {
                                cartItems.update(
                                  filteredProducts[index]['name'],
                                  (value) => value + quantity,
                                  ifAbsent: () => quantity,
                                );
                              });
                            },
                          ),
                        ),
                      );
                    },
                    child: ProductGridItem(
                      name: filteredProducts[index]['name'],
                      price: filteredProducts[index]['price'],
                      image: filteredProducts[index]['image'],
                      isInCart: cartItems
                          .containsKey(filteredProducts[index]['name']),
                      onAddToCart: () {
                        setState(() {
                          cartItems.update(
                            filteredProducts[index]['name'],
                            (value) => value + 1,
                            ifAbsent: () => 1,
                          );
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                '${filteredProducts[index]['name']} added to cart'),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
