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
    final double carouselHeight = height * 0.22;

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
            viewportFraction: 1,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            enlargeCenterPage: true,
            reverse: false,
            onPageChanged: (index, i) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          itemBuilder: (context, i, id) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              margin: const EdgeInsets.only(
                top: 10.0,
              ),
              elevation: 6.0,
              shadowColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(30.0),
                ),
                child: CarouselImage(imageUrl: widget.images[i].imagePath),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
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
