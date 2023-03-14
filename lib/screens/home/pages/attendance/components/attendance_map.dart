import 'package:get/get.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:sizer/sizer.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/commons/functions/cache_tile_provider.dart';
import 'package:siangmalam/commons/controllers/home/attendance_controller.dart';

/* Created By Dwi Sutrisno */

class AttendanceMap extends GetView<AttendanceController> {
  const AttendanceMap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("data distanceTollerance : ${controller.deviceCoordinate.value.distanceTolerance}");
    // print("data latitude : ${controller.deviceCoordinate.value.latitude}");
    // print("data longitude : ${controller.deviceCoordinate.value.longitude}");
    // print("static tolerance : ${AppStatic.workPlaceLocation.distanceTolerance}");
    var circleMarkers = <CircleMarker>[
      CircleMarker(
          point: LatLng(AppStatic.workPlaceLocation.latitude!, AppStatic.workPlaceLocation.longitude!),
          color: greyBG.withOpacity(0.7),
          borderStrokeWidth: 1,
          useRadiusInMeter: true,
          radius: AppStatic.workPlaceLocation.distanceTolerance!.toDouble() // 2000 meters | 2 km
          ),
    ];

    return SafeArea(
      child: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Obx(
          () => FlutterMap(
            mapController: controller.mapController.value,
            options: MapOptions(
              center: LatLng(
                controller.deviceCoordinate.value.latitude!,
                controller.deviceCoordinate.value.longitude!,
              ),
              zoom: 18.0,
              maxZoom: 18,
              minZoom: 12,
              interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
                tileProvider: const CachedTileProvider(),
              ),
              CircleLayerOptions(circles: circleMarkers),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    height: 10.h,
                    width: 10.w,
                    point: LatLng(
                      AppStatic.workPlaceLocation.latitude!,
                      AppStatic.workPlaceLocation.longitude!,
                    ),
                    builder: (ctx) => Icon(
                      Icons.share_location,
                      size: 6.w,
                      color: Colors.yellow,
                    ),
                  ),
                ],
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    height: 10.h,
                    width: 10.w,
                    point: LatLng(
                      controller.deviceCoordinate.value.latitude!,
                      controller.deviceCoordinate.value.longitude!,
                    ),
                    builder: (ctx) => Image.asset(markerImage),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
