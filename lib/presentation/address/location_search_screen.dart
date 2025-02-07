import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:provider/provider.dart';

import '../../utils/api_status.dart';
import 'address_view_model.dart';
import 'location_screen.dart';

class LocationSearchScreen extends StatefulWidget {
  const LocationSearchScreen({super.key});

  @override
  State<LocationSearchScreen> createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  late AddressViewModel viewModel;

  @override
  void initState() {
    viewModel = Provider.of<AddressViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.getAddress();
    });
    super.initState();
  }

  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _locationResults =
      []; // Store address, lat, and lon
  final String _selectedLocation = "";

  // Search for locations as the user types
  Future<void> _searchLocation(String query) async {
    if (query.isEmpty) {
      setState(() {
        _locationResults = [];
      });
      return;
    }

    try {
      // Get locations based on the address
      List<geo.Location> locations = await geo.locationFromAddress(query);

      List<Map<String, dynamic>> addressResults = [];
      for (var location in locations) {
        // Convert latitudes and longitudes to addresses
        List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
            location.latitude, location.longitude);

        if (placemarks.isNotEmpty) {
          var placemark = placemarks.first;
          addressResults.add({
            'address': [
              placemark.street?.isNotEmpty == true ? placemark.street : null,
              placemark.subLocality?.isNotEmpty == true
                  ? placemark.subLocality
                  : null,
              placemark.locality?.isNotEmpty == true
                  ? placemark.locality
                  : null,
              placemark.postalCode?.isNotEmpty == true
                  ? placemark.postalCode
                  : null,
              placemark.administrativeArea?.isNotEmpty == true
                  ? placemark.administrativeArea
                  : null,
              placemark.country?.isNotEmpty == true ? placemark.country : null
            ]
                .where((element) => element != null)
                .join(', '), // Join only available parts
            'latitude': location.latitude,
            'longitude': location.longitude,
          });
        }
      }

      setState(() {
        _locationResults = addressResults;
      });
    } catch (e) {
      setState(() {
        _locationResults = [
          {"address": "Searching...", "latitude": null, "longitude": null}
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Location'),
      ),
      body: Consumer<AddressViewModel>(builder: (context, viewModel, child) {
        if (viewModel.loadingAddress) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for a location',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      _searchLocation(_searchController.text);
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (query) {
                  _searchLocation(query); // Search as you type
                },
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LocationScreen(
                      latitude:
                          null, // No predefined location, fetch GPS location
                      longitude: null,
                    ),
                  ),
                ),
                child: const Text('Use My Current Location'),
              ),
              const Divider(),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const LocationScreen()), // New address flow
                ),
                child: const Text('Add New Address'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.address.length,
                  itemBuilder: (context, index) {
                    final address = viewModel.address[index];
                    final isSelected =
                        address.activeStatus == 1; // Check if it's selected

                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text(address.name ?? ''),
                        subtitle:
                            Text('${address.addressLine1}, ${address.pincode}'),
                        trailing: isSelected
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'Selected',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : null, // Only show if selected
                        onTap: viewModel.loadingAddress ||
                                viewModel.addresscreateResponse.status ==
                                    ApiStatus.loading
                            ? null
                            : () async {
                                await viewModel.updateStatus(address.id ?? 0);
                                        await viewModel.getAddress();  // This should repull the addresses after the status change

                                // Ensure the UI is rebuilt after the status update
                              },
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _locationResults.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> location = _locationResults[index];
                    String address = location['address'];
                    double? latitude = location['latitude'];
                    double? longitude = location['longitude'];

                    return ListTile(
                      title: Text(address),
                      onTap: () {
                        if (latitude != null && longitude != null) {
                          print('$latitude - $longitude');
                          print('Address - $address');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LocationScreen(
                                latitude: latitude,
                                longitude: longitude,
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              _selectedLocation.isNotEmpty
                  ? Text('Selected Location: $_selectedLocation')
                  : Container(),
            ],
          ),
        );
      }),
    );
  }
}
