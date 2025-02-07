import 'package:flutter/material.dart';

import '../location_search_screen.dart';

class LocationSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 20,
      right: 20,
      child: TextField(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LocationSearchScreen()),
        ),
        decoration: InputDecoration(
          hintText: 'Search for a location',
          suffixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}