import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kakao_map_sdk/kakao_map_sdk.dart';
import 'package:moly_mobile/features/map/presentation/widgets/location_dot.dart';
import 'package:moly_mobile/features/map/presentation/widgets/map_fab.dart';
import 'package:moly_mobile/features/map/presentation/widgets/my_location_button.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  KakaoMapController? _controller;

  Future<void> _goToCurrentLocation({bool addMarker = false}) async {
    try {
      final position = await _currentPosition();
      final controller = _controller;
      if (position == null || controller == null || !mounted) return;

      final latLng = LatLng(position.latitude, position.longitude);
      await controller.moveCamera(
        CameraUpdate.newCenterPosition(latLng, zoomLevel: 18),
        animation: const CameraAnimation(500),
      );

      if (!addMarker || !mounted) return;
      final icon = await KImage.fromWidget(
        const LocationDot(),
        const Size(60, 60),
        context: context,
      );
      await controller.labelLayer.addPoi(
        latLng,
        style: PoiStyle(icon: icon, anchor: const KPoint(0.5, 0.3)),
      );
    } catch (e) {
      debugPrint('현재 위치 이동 실패: $e');
    }
  }

  Future<Position?> _currentPosition() async {
    if (!await Geolocator.isLocationServiceEnabled()) return null;

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return null;
    }

    return Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          KakaoMap(
            option: const KakaoMapOption(
              position: LatLng(37.5665, 126.9780),
              zoomLevel: 16,
              mapType: MapType.normal,
            ),
            onMapReady: (controller) {
              _controller = controller;
              _goToCurrentLocation(addMarker: true);
            },
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 20,
            child: Center(
              child: MyLocationButton(onTap: _goToCurrentLocation),
            ),
          ),
          const MapFab(),
        ],
      ),
    );
  }
}
