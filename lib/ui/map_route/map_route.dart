import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:task/utils/constants.dart';

import '../card/widgets/custom_app_bar.dart';

class MapRoute extends StatefulWidget {
  const MapRoute({Key? key}) : super(key: key);

  @override
  State<MapRoute> createState() => _MapRouteState();
}

class _MapRouteState extends State<MapRoute> {
  final Completer<GoogleMapController> _controller = Completer();

  static  LatLng sourceLocation = LatLng(41.282382, 69.211862);
  static const LatLng destination = LatLng(41.2598705, 69.1872837);

  List<LatLng> polyLinesCoordinates = [];
  LocationData? currentLocation;

  Future<void> getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then(
      (location) {
        sourceLocation = LatLng(location.latitude!, location.longitude!);
        currentLocation = location;
        setState(() {});
      },
    );
    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;

      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 13.5,
            target: LatLng(newLoc.latitude!, newLoc.longitude!),
          ),
        ),
      );
      setState(() {});
    });
  }

  Future<void> getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult polylineResult = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    print(">>>>>>>>><<<<>><<>><${polylineResult.points[0]},.,<><><");

    if (polylineResult.points.isNotEmpty) {
      polylineResult.points.forEach((point) {
        polyLinesCoordinates.add(LatLng(point.latitude, point.longitude));

        debugPrint('----- POINT -----\nLAT: ${point.latitude}\nLONG: ${point.longitude}');
      });
      setState(() {});
      debugPrint("---------- ${polyLinesCoordinates.length.toString()} POINTS ----------");
    }
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    await getCurrentLocation();
    await getPolyPoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Map Route',
      ),
      body: currentLocation == null
          ? const Center(child: CircularProgressIndicator.adaptive())
          : GoogleMap(
              markers: {
                Marker(
                  markerId: const MarkerId("currentLocation"),
                  position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                ),
                Marker(
                  markerId: const MarkerId("source"),
                  position: sourceLocation,
                ),
                const Marker(
                  markerId: MarkerId("B"),
                  position: destination,
                ),
              },
              polylines: {
                Polyline(
                  polylineId: const PolylineId('myRoute'),
                  color: Colors.red,
                  width: 6,
                  points: polyLinesCoordinates,
                )
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: 13.5,
              ),
              onMapCreated: (mapController) {
                _controller.complete(mapController);
              },
            ),
    );
  }
}
