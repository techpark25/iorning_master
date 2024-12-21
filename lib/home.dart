import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:laundry_app/Product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Services App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home Page'),
      //   backgroundColor: Colors.blue,
      // ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Greeting Section
          Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Hi, Karthik',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Good Morning!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Carousel Section
          CarouselSlider(
            items: [
              _buildBannerImage("assets/img/banner_1.jpg"),
              _buildBannerImage("assets/img/banner_2.jpg"),
              _buildBannerImage("assets/img/banner_3.jpg"),
            ],
            options: CarouselOptions(
              height: 160.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          ),

          const SizedBox(height: 20),

          // Services Offered Title
          const Center(
            child: Text(
              "Services Offered",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Services Boxes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildServiceBox(context, "Ironing", "assets/img/cloth-iron.jpg",
                  Icons.iron_sharp, const ProductsPage()),
              _buildServiceBox(
                  context,
                  "Washing",
                  "assets/img/cloth-washing.jpg",
                  Icons.waves_sharp,
                  const ProductsPage()),
            ],
          ),

          const SizedBox(height: 20),

          // Steps Section Title
          const Center(
            child: Text(
              "Steps to Get Started",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Steps Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStepCircle(Icons.check, "Step 1", "Select Service"),
              _buildStepCircle(Icons.check, "Step 2", "Select Product"),
              _buildStepCircle(Icons.check, "Step 3", "Get Relax"),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildBannerImage(String imagePath) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Service box widget with background image, overlay, and navigation
  Widget _buildServiceBox(BuildContext context, String serviceName,
      String backgroundImage, IconData icon, Widget targetPage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      },
      child: Container(
        width: 150,
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 25.0,
              ),
              const SizedBox(height: 10),
              Text(
                serviceName,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Step Circle widget with description
  Widget _buildStepCircle(IconData icon, String stepTitle, String description) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromARGB(255, 255, 157, 0), width: 3),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              icon,
              color: const Color.fromARGB(255, 255, 157, 0),
              size: 20.0,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          stepTitle,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

// Ironing Service Page
class IroningPage extends StatelessWidget {
  const IroningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ironing Service"),
        backgroundColor: Colors.blue,
      ),
      body: const Center(child: Text("Welcome to Ironing Service!")),
    );
  }
}

// Washing Service Page
class WashingPage extends StatelessWidget {
  const WashingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Washing Service"),
        backgroundColor: Colors.blue,
      ),
      body: const Center(child: Text("Welcome to Washing Service!")),
    );
  }
}
