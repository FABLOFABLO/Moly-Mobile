import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kakao_map_sdk/kakao_map_sdk.dart';
import 'package:moly_mobile/core/constants/assets.dart';
import 'package:moly_mobile/core/constants/color.dart';
import 'package:moly_mobile/common/widgets/moly_draggable_sheet.dart';
import 'package:moly_mobile/core/constants/text_style.dart';
import 'package:moly_mobile/features/map/presentation/widgets/location_dot.dart';
import 'package:moly_mobile/features/map/presentation/widgets/map_fab.dart';
import 'package:moly_mobile/features/map/presentation/widgets/memo_delete_dialog.dart';
import 'package:moly_mobile/features/map/presentation/widgets/memo_detail_sheet.dart';
import 'package:moly_mobile/features/map/presentation/widgets/memo_write_sheet.dart';
import 'package:moly_mobile/features/map/presentation/widgets/my_location_button.dart';
import 'package:moly_mobile/features/map/presentation/widgets/placement_confirm_bar.dart';

const double _pinHeight = 28;
const double _pinUprightAngle = 50;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  KakaoMapController? _controller;

  bool _placing = false;
  Poi? _placementPoi;
  LatLng? _placedPoint;

  final Map<String, KImage> _pinCache = {};
  final List<MemoPin> _memos = [];

  Future<void> _goToCurrentLocation({bool addMarker = false}) async {
    try {
      final position = await _currentPosition();
      final controller = _controller;
      if (position == null || controller == null || !mounted) return;

      final latLng = LatLng(position.latitude, position.longitude);
      await controller.moveCamera(
        CameraUpdate.newCenterPosition(latLng, zoomLevel: 18),
        animation: const CameraAnimation(250),
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

    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  Future<KImage> _pinImage(String asset, double dpr) async {
    final cached = _pinCache[asset];
    if (cached != null) return cached;

    final info = await vg.loadPicture(SvgAssetLoader(asset), null);
    final aspect = info.size.width / info.size.height;
    final width = (_pinHeight * aspect).round();
    const height = _pinHeight;
    final pw = (width * dpr).round();
    final ph = (height * dpr).round();

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final scale = ph / info.size.height;
    canvas.scale(scale);
    canvas.drawPicture(info.picture);
    final image = await recorder.endRecording().toImage(pw, ph);
    info.picture.dispose();
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();

    final kImage = KImage.fromData(
      bytes!.buffer.asUint8List(),
      width,
      height.round(),
    );
    _pinCache[asset] = kImage;
    return kImage;
  }

  Future<PoiStyle> _pinStyle(String asset) async {
    final icon = await _pinImage(
      asset,
      MediaQuery.of(context).devicePixelRatio,
    );
    return PoiStyle(icon: icon, anchor: const KPoint(0.5, 1.0));
  }

  Future<void> _setPinUpright(MemoPin memo, bool upright) async {
    await memo.poi.rotate(upright ? _pinUprightAngle : 0, 250);
  }

  Future<T?> _showSheet<T>(
    Widget child, {
    bool dismissible = false,
    double initialSize = 0.5,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: dismissible,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => MolyDraggableSheet(
        initialSize: initialSize,
        onClose: () => Navigator.of(sheetContext).pop(),
        child: child,
      ),
    );
  }

  void _startMemoPlacement() {
    setState(() => _placing = true);
  }

  Future<void> _onMapClick(KPoint point, LatLng position) async {
    if (!_placing) return;
    final controller = _controller;
    if (controller == null) return;

    final poi = _placementPoi;
    if (poi != null) {
      await poi.move(position);
      if (!mounted) return;
      setState(() => _placedPoint = position);
      return;
    }

    final style = await _pinStyle(SvgAssets.pin);
    final newPoi = await controller.labelLayer.addPoi(position, style: style);
    if (!mounted) return;
    setState(() {
      _placementPoi = newPoi;
      _placedPoint = position;
    });
  }

  Future<void> _removePlacementPoi() async {
    final poi = _placementPoi;
    if (poi != null) await _controller?.labelLayer.removePoi(poi);
  }

  Future<void> _cancelPlacement() async {
    await _removePlacementPoi();
    if (!mounted) return;
    setState(() {
      _placing = false;
      _placementPoi = null;
      _placedPoint = null;
    });
  }

  Future<void> _openMemo() async {
    setState(() => _placing = false);

    final poi = _placementPoi;
    final point = _placedPoint;
    if (point != null) {
      await _controller?.moveCamera(
        CameraUpdate.newCenterPosition(point, zoomLevel: 18),
        animation: const CameraAnimation(250),
      );
    }
    if (!mounted) return;
    final text = await _showSheet<String>(
      MemoWriteSheet(onSubmit: (t) => Navigator.of(context).pop(t)),
      initialSize: 0.4,
    );

    if (text != null && poi != null && point != null) {
      _memos.add(
        MemoPin(poi: poi, point: point, text: text, createdAt: DateTime.now()),
      );
      // TODO: 작성된 메모를 서버에 저장
    } else {
      await _removePlacementPoi();
    }
    _placementPoi = null;
    _placedPoint = null;
  }

  Future<void> _onPoiClick(LabelController controller, Poi poi) async {
    if (_placing) return;
    MemoPin? found;
    for (final m in _memos) {
      if (m.poi.id == poi.id) {
        found = m;
        break;
      }
    }
    if (found == null) return;
    final memo = found;

    await _controller?.moveCamera(
      CameraUpdate.newCenterPosition(memo.point, zoomLevel: 18),
      animation: const CameraAnimation(250),
    );
    await _setPinUpright(memo, true);
    if (!mounted) return;

    await _showSheet<void>(
      MemoDetailSheet(
        text: memo.text,
        createdAt: memo.createdAt,
        onSave: (t) => memo.text = t,
        onDelete: () => _onDeletePressed(memo),
      ),
      dismissible: true,
      initialSize: 0.5,
    );

    if (_memos.contains(memo)) await _setPinUpright(memo, false);
  }

  Future<void> _onDeletePressed(MemoPin memo) async {
    final ok = await showMemoDeleteDialog(context);
    if (!ok) return;
    await _controller?.labelLayer.removePoi(memo.poi);
    _memos.remove(memo);
    // TODO: 서버에서 메모 삭제
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            onMapClick: _onMapClick,
            onPoiClick: _onPoiClick,
          ),
          if (!_placing) ...[
            Positioned(
              top: 0,
              bottom: 0,
              right: 20,
              child: Center(
                child: MyLocationButton(onTap: _goToCurrentLocation),
              ),
            ),
            MapFab(onMemo: _startMemoPlacement),
          ],
          if (_placing) ...[
            Positioned(
              top: 0,
              left: 20,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: GestureDetector(
                    onTap: _cancelPlacement,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: MolyColor.hm,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, color: MolyColor.brown300),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: MolyColor.black.withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _placedPoint == null
                            ? '원하는 위치를 탭해 핀을 놓으세요'
                            : '핀을 옮기려면 지도를 다시 탭하세요',
                        style: MolyTextStyle.captionMedium.copyWith(
                          color: MolyColor.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: PlacementConfirmBar(
                hasPoint: _placedPoint != null,
                onConfirm: _openMemo,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class MemoPin {
  MemoPin({
    required this.poi,
    required this.point,
    required this.text,
    required this.createdAt,
  });

  final Poi poi;
  final LatLng point;
  String text;
  final DateTime createdAt;
}
