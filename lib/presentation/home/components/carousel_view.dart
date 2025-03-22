import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../data/carousel/carousel_list_response.dart';
import 'carousel_image.dart';

class CarouselVieww extends StatefulWidget {
  const CarouselVieww({
    super.key,
    required this.images,
    required this.isLoading,
  });

  final List<Carousel> images;
  final bool isLoading;

  @override
  _CarouselViewwState createState() => _CarouselViewwState();
}

class _CarouselViewwState extends State<CarouselVieww> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double carouselHeight = height * 0.20;
    final double width = MediaQuery.of(context).size.height;
    final double carouselWidth = width * 0.20;

    if (widget.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (widget.images.isEmpty) {
      return const Center(
        child: Text(
          "No images available",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider.builder(
          itemCount: widget.images.length,
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.25,
            viewportFraction: 1,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            enlargeCenterPage: false, // No zoom effect
            reverse: false,
            autoPlayAnimationDuration:
                const Duration(milliseconds: 500), // Fast transition
            autoPlayCurve: Curves.linear, // Linear movement, no fade-in effect
            scrollPhysics: const BouncingScrollPhysics(), // Smooth scrolling
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          itemBuilder: (context, i, id) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                ),
                child: CarouselImage(imageUrl: widget.images[i].imagePath),
              ),
            ),
          ),
        ),
        const SizedBox(height: 0),
        // Uncomment if you want indicators
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     for (var i = 0; i < widget.images.length; i++)
        //       CarouselIndicator(isActive: currentIndex == i),
        //   ],
        // )
      ],
    );
  }
}
