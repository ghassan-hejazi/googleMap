import 'dart:async';

import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetxController {
  final isLoading = false.obs;
  StreamSubscription<Position>? positionStream;

  @override
  void onInit() async {
    isLoading(true);
    position = await determinePosition();
    positionStream = Geolocator.getPositionStream(
            locationSettings:
                const LocationSettings(accuracy: LocationAccuracy.best))
        .listen((Position position) {
      markers(position.latitude, position.longitude);
    });
    isLoading(false);
    super.onInit();
  }

  Position? position;
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  GoogleMapController? controllerS;
  googleMapController(GoogleMapController controller) {
    controllerS = controller;
  }

  markers(newlatitude, newlongitude) {
    marker.remove(const Marker(
      markerId: MarkerId('1'),
    ));
    marker.add(
      Marker(
        markerId: const MarkerId('1'),
        position: LatLng(
          newlatitude,
          newlongitude,
        ),
      ),
    );
  }

  Set<Marker> marker = {};
}
//AIzaSyCmD0EaHA7bdXqbbtI0JesWaobQTAWSomQ