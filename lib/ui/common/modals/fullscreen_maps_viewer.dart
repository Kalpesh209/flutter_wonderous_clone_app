import 'package:flutter_wonderous_clone_app/common_libs.dart';
import 'package:flutter_wonderous_clone_app/logic/data/wonder_data.dart';
import 'package:flutter_wonderous_clone_app/logic/data/wonder_type.dart';
import 'package:flutter_wonderous_clone_app/main.dart';
import 'package:flutter_wonderous_clone_app/ui/common/controls/app_header.dart';
import 'package:flutter_wonderous_clone_app/ui/common/google_maps_marker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FullscreenMapsViewer extends StatelessWidget {
  FullscreenMapsViewer({super.key, required this.type});
  final WonderType type;

  WonderData get data => wondersLogic.getData(type);
  late final startPos =
      CameraPosition(target: LatLng(data.lat, data.lng), zoom: 17);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          top: false,
          child: GoogleMap(
            mapType: MapType.hybrid,
            markers: {getMapsMarker(startPos.target)},
            initialCameraPosition: startPos,
            myLocationButtonEnabled: false,
          ),
        ),
        AppHeader(isTransparent: true),
      ],
    );
  }
}
