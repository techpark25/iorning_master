import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../../data/address/data/address.dart';
import '../../themes.dart';
import '../address/location_search_screen.dart';
import 'components/carousel_view.dart';
import 'components/category_list.dart';
import 'home_view_model.dart';
import '../address/address_view_model.dart';
import '../product/product_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeViewModel viewModel;
  late ProductViewModel pviewModel;
  late AddressViewModel aviewModel;
  String _currentLocation =
      'Getting current location...'; // State variable to store the location

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<HomeViewModel>(context, listen: false);
    pviewModel = Provider.of<ProductViewModel>(context, listen: false);
    aviewModel = Provider.of<AddressViewModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.getMenus();
      viewModel.getCarouselImages();
      viewModel.getUser();
      aviewModel.getActiveAddress();
      _getCurrentLocation(); // Fetch location on init
    });
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  Future<void> _getCurrentLocation() async {
  if (!mounted) return; // Ensure widget is still in the tree

  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  LocationPermission permission = await Geolocator.checkPermission();

  if (!serviceEnabled || permission == LocationPermission.denied) {
    if (mounted) {
      _showPermissionBottomSheet(); // Show bottom sheet if permission is not granted
    }
    return;
  }

  if (permission == LocationPermission.deniedForever) {
    if (mounted) {
      setState(() {
        _currentLocation = 'Location permission permanently denied';
      });
    }
    return;
  }

  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

  if (placemarks.isNotEmpty) {
    if (mounted) {
      setState(() {
        _currentLocation =
            '${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea}, ${placemarks.first.postalCode}, ${placemarks.first.country}';
      });
    }
  } else {
    if (mounted) {
      setState(() {
        _currentLocation = '';
      });
    }
  }
}


  void _showPermissionBottomSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_on, size: 50, color: Colors.red),
              const SizedBox(height: 10),
              const Text(
                "Location Permission Required",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "We need access to your location to show relevant services. Please grant permission.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context); // Close bottom sheet
                  LocationPermission newPermission =
                      await Geolocator.requestPermission();
                  if (newPermission == LocationPermission.whileInUse ||
                      newPermission == LocationPermission.always) {
                    _getCurrentLocation(); // Retry fetching location after granting permission
                  }
                },
                child: const Text("Grant Permission"),
              ),
            ],
          ),
        );
      },
    );
  }
@override
void dispose() {
  super.dispose();
  // Cancel any active location requests or listeners here
}

  @override
  Widget build(BuildContext context) {
    final aviewModel = Provider.of<AddressViewModel>(context);
    Address? activeAddress;

    for (var address in aviewModel.address) {
      if (address.activeStatus == 1) {
        activeAddress = address;
        break; // Stop the loop once the active address is found
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const LocationSearchScreen()),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on,
                    color: AppThemes.backgroundColor,
                    size: 15,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    aviewModel.address.isNotEmpty
                        ? _capitalizeFirstLetter(
                            activeAddress?.name ?? '')
                        : 'Getting current location...',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppThemes.backgroundColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppThemes.backgroundColor,
                    size: 15,
                  ),
                ],
              ),
              // Location information will now be directly displayed without FutureBuilder
              Text(
                aviewModel.address.isNotEmpty
                    ? '${activeAddress?.houseOrBuildingNo} , $_currentLocation'
                    : 'Address not available, $_currentLocation',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppThemes.backgroundColor,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
      body: Consumer<HomeViewModel>(builder: (context, viewModel, child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              // Container(
              //   padding: const EdgeInsets.only(
              //       left: 20, right: 20, top: 20, bottom: 0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             'Hi, ${viewModel.user?.name ?? ''}',
              //             style: const TextStyle(
              //               fontSize: 20,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //           const SizedBox(height: 5),
              //           const Text(
              //             'Good Morning!',
              //             style: TextStyle(
              //               fontSize: 14,
              //               color: Colors.grey,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 20),
              CarouselVieww(
                images: viewModel.carouselImages,
                isLoading: viewModel.loadingCarouselImages,
              ),
              const SizedBox(height: 10),

              // Services Offered Title
              // const Center(
              //   child: Text(
              //     "Services Offered",
              //     style: TextStyle(
              //       fontSize: 16,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              CategoryList(
                categories: viewModel.menus,
                subcategories: pviewModel.subcategories,
              ),

              Container(
                width: double.infinity, // Full width // Add padding for spacing
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/img/resetpasswrod-bg.webp"), // Background image
                    fit: BoxFit.cover, // Cover the full container
                  ),
                ),
                child: Stack(
                  children: [
                    // Black Overlay Effect - Positioned.fill ensures it covers the whole container
                    Positioned.fill(
                      child: Container(
                        color: Colors.black
                            .withOpacity(0.6), // Adjust opacity for darkness
                      ),
                    ),

                    // Content Section (Wrapped in a Column)
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(
                            child: Text(
                              "Steps to Get Started",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors
                                    .white, // Set text color to white for contrast
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Steps Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildStepCircle(
                                  Icons.check, "Step 1", "Select Service"),
                              _buildStepCircle(
                                  Icons.check, "Step 2", "Select Product"),
                              _buildStepCircle(
                                  Icons.check, "Step 3", "Get Relax"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStepCircle(IconData icon, String stepTitle, String description) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: AppThemes.backgroundColor, width: 3),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              icon,
              color: AppThemes.backgroundColor,
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
            color: AppThemes.backgroundColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(
            fontSize: 12,
            color: AppThemes.backgroundColor,
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
