import 'package:flutter_wonderous_clone_app/assets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Marker getMapsMarker(LatLng position) => Marker(
      markerId: MarkerId('0'),
      position: position,
      icon: AppBitmaps.mapMarker,
    );
