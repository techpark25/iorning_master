import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMap extends StatelessWidget {
  final LatLng? currentLocation;
  final Set<Marker> markers;
  final Function(GoogleMapController) onMapCreated;
  final Function(CameraPosition) onCameraMove;
  final VoidCallback onCameraIdle;

  const LocationMap({
    required this.currentLocation,
    required this.markers,
    required this.onMapCreated,
    required this.onCameraMove,
    required this.onCameraIdle,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: currentLocation ?? const LatLng(0, 0),
        zoom: 15.0,
      ),
      onMapCreated: onMapCreated,
      markers: markers,
      onCameraMove: onCameraMove,
      onCameraIdle: onCameraIdle,
    );
  }
}

