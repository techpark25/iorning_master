import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:laundry_application/utils/api_status.dart';
import 'package:provider/provider.dart';

import 'address_view_model.dart';
import 'components/components.dart';

class LocationScreen extends StatefulWidget {
  final double? latitude;
  final double? longitude;

  const LocationScreen({super.key, this.latitude, this.longitude});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GoogleMapController? _mapController;
  LatLng? _currentLocation;
  String _address = "Move the map to select location";
  LatLng? _lastMapPosition;
  final Set<Marker> _markers = {};
  late AddressViewModel addressViewModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController houseNoController = TextEditingController();
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.latitude != null && widget.longitude != null) {
      _currentLocation = LatLng(widget.latitude!, widget.longitude!);
    } else {
      _getCurrentLocation();
    }
    addressViewModel = Provider.of<AddressViewModel>(context, listen: false);
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Location permission denied")));
        }
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      if (mounted) {
        setState(() {
          _currentLocation = LatLng(position.latitude, position.longitude);
          _markers.clear();
          _markers.add(
            Marker(
              markerId: const MarkerId('current-location'),
              position: _currentLocation!,
              infoWindow: const InfoWindow(title: 'Your Location'),
            ),
          );
          _mapController?.animateCamera(
              CameraUpdate.newLatLngZoom(_currentLocation!, 15));
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to get current location")));
      }
    }
  }

  Future<void> _getAddress(LatLng latLng) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

      if (mounted && placemarks.isNotEmpty) {
        setState(() {
          _address = '${placemarks[0].street}, ${placemarks[0].locality}, '
              '${placemarks[0].administrativeArea}, ${placemarks[0].country}';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _address = "Fetching Address...";
        });
      }
    }
  }

  void _confirmLocation(LatLng latLng) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddressForm(
        latitude: latLng.latitude.toString(),
        longitude: latLng.longitude.toString(),
        addressLine1Controller: addressLine1Controller,
        addressLine2Controller: addressLine2Controller,
        nameController: nameController,
        houseNoController: houseNoController,
        landmarkController: landmarkController,
        pincodeController: pincodeController,
        onTap: addressViewModel.addresscreateResponse.status ==
                ApiStatus.loading
            ? null
            : () async {
                await addressViewModel.createAddress(
                  addressLine1: addressLine1Controller.text,
                  addressLine2: addressLine2Controller.text,
                  name: nameController.text,
                  houseNo: houseNoController.text,
                  landmark: landmarkController.text,
                  latitude: latLng.latitude.toString(),
                  longitude: latLng.longitude.toString(),
                  pincode: pincodeController.text,
                  status: true,
                );
                Navigator.pop(context);
                                Navigator.pop(context);
                                                                Navigator.pop(context);


              },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Location")),
      body: Stack(
        children: [
          LocationMap(
            currentLocation: _currentLocation,
            markers: _markers,
            onMapCreated: (controller) => _mapController = controller,
            onCameraMove: (position) => _lastMapPosition = position.target,
            onCameraIdle: () {
              if (_lastMapPosition != null) {
                _getAddress(_lastMapPosition!);
              }
            },
          ),
          LocationSearchBar(),
          Positioned(
            bottom: 120,
            left: 20,
            right: 20,
            child: TextButton(
              onPressed: _getCurrentLocation,
              child: const Text(
                "Use Current Location",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 5)
                ],
              ),
              child: Text(
                _address,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                if (_lastMapPosition != null) {
                  _confirmLocation(_lastMapPosition!);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text("Please move the map to select a location")),
                  );
                }
              },
              child: const Text("Confirm Location"),
            ),
          ),
        ],
      ),
    );
  }
}
