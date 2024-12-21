import 'package:flutter/material.dart';
import 'package:laundry_app/AddtoCart.dart';
import 'Schedule.dart';
import 'AddtoCart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Select Items',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProductsPage(),
    );
  }
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final List<Map<String, dynamic>> menProducts = [
    {
      "name": "Shirt",
      "price": 150,
      "quantity": 0,
      "image": "assets/img/shirt.png"
    },
    {
      "name": "Jean Pant",
      "price": 250,
      "quantity": 0,
      "image": "assets/img/jean.png"
    },
    {
      "name": "T Shirt",
      "price": 350,
      "quantity": 0,
      "image": "assets/img/t-shirt.png"
    },
    {
      "name": "Track Pants",
      "price": 450,
      "quantity": 0,
      "image": "assets/img/track-pants.webp"
    },
  ];

  final List<Map<String, dynamic>> womenProducts = [
    {
      "name": "Women Saree",
      "price": 120,
      "quantity": 0,
      "image": "assets/img/saree.png"
    },
    {
      "name": "Women T-Shirts",
      "price": 220,
      "quantity": 0,
      "image": "assets/img/girl-sthirt.webp"
    },
  ];

  String activeCategory = "Men"; // Default active category

  // Getter for total quantity
  int get totalQuantity {
    return menProducts.fold<int>(
          0,
          (sum, product) => sum + (product['quantity'] as int),
        ) +
        womenProducts.fold<int>(
          0,
          (sum, product) => sum + (product['quantity'] as int),
        );
  }

  // Getter for total price
  int get totalPrice {
    return menProducts.fold<int>(
          0,
          (sum, product) =>
              sum + ((product['price'] as int) * (product['quantity'] as int)),
        ) +
        womenProducts.fold<int>(
          0,
          (sum, product) =>
              sum + ((product['price'] as int) * (product['quantity'] as int)),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Items'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Horizontal Accordion Menu
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Men Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      activeCategory = "Men";
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      gradient: activeCategory == "Men"
                          ? const LinearGradient(
                              colors: [
                                Color(0xFFFDC846), // Golden Yellow
                                Color(0xFFD32943), // Red
                              ],
                            )
                          : null, // Gradient only for active
                      color: activeCategory != "Men" ? Colors.grey[300] : null,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      "Men",
                      style: TextStyle(
                        color: activeCategory == "Men"
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Women Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      activeCategory = "Women";
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: activeCategory == "Women"
                          ? Colors.blue
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      "Women",
                      style: TextStyle(
                        color: activeCategory == "Women"
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Product List for Active Category
            Expanded(
              child: ListView.builder(
                itemCount: activeCategory == "Men"
                    ? menProducts.length
                    : womenProducts.length,
                itemBuilder: (context, index) {
                  final product = activeCategory == "Men"
                      ? menProducts[index]
                      : womenProducts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          // Product Image
                          Image.network(
                            product['image'],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 16),
                          // Product Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['name'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Price: ₹${product['price']}'),
                              ],
                            ),
                          ),
                          // Quantity Controls
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    if (product['quantity'] > 0) {
                                      product['quantity']--;
                                    }
                                  });
                                },
                              ),
                              Text(
                                product['quantity'].toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    product['quantity']++;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Total Quantity and Price
            Container(
              margin: const EdgeInsets.symmetric(
                  vertical: 20.0), // Margin top and bottom
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                    141, 0, 0, 0), // Background color black
                borderRadius: BorderRadius.circular(10.0), // Border radius
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price: ( $totalQuantity items) ',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white, // Text color white
                      ),
                    ),
                    Text(
                      'Total Price: ₹$totalPrice',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white, // Text color white
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Book Timing Button with Bottom Margin
            Container(
              margin: const EdgeInsets.only(bottom: 20.0), // Set bottom margin
              width: double.infinity, // Make the button take full width
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.transparent, // Set background color as transparent
                  shadowColor:
                      Colors.transparent, // Remove shadow if not needed
                  padding: EdgeInsets
                      .zero, // Remove padding to apply gradient correctly
                ),
                onPressed: () {
                  // Handle book timing logic
                  List<Map<String, dynamic>> selectedProducts = [
                    ...menProducts.where((product) => product['quantity'] > 0),
                    ...womenProducts
                        .where((product) => product['quantity'] > 0),
                  ];

                  if (selectedProducts.isNotEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Selected Products'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: selectedProducts.map((product) {
                              return Text(
                                  "${product['name']} - Quantity: ${product['quantity']}");
                            }).toList(),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddToCart()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('No products selected.'),
                      ),
                    );
                  }
                },
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFDC846), // Golden Yellow
                        Color(0xFFD32943), // Red
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius:
                        BorderRadius.circular(8.0), // Optional: Rounded corners
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0), // Optional: Adjust vertical padding
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16), // Text color for the button
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
