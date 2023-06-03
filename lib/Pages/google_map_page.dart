import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'home_controller.dart';

class GoogleMapPage extends GetView<HomeController> {
  const GoogleMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<Position>(
          stream: Geolocator.getPositionStream(
              locationSettings:
                  const LocationSettings(accuracy: LocationAccuracy.best)),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(children: [
                SizedBox(
                  height: 500,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    markers: {
                      // controller.marker.last,
                      Marker(
                        markerId: const MarkerId('1'),
                        position: LatLng(
                          snapshot.data!.latitude,
                          snapshot.data!.longitude,
                        ),
                        infoWindow: InfoWindow(
                          title: '1',
                          onTap: () {},
                        ),
                      ),
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(controller.position!.latitude,
                          controller.position!.longitude),
                      zoom: 18,
                    ),
                    onMapCreated: (GoogleMapController controllers) async {
                      await controller.googleMapController(controllers);
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // await controller.controllerS!.animateCamera(CameraUpdate.newLatLng(const LatLng(31.41834, 34.34933)));
                    // var xy = await controller.controllerS!.getLatLng(ScreenCoordinate(x: 200, y: 200));
                    // print(xy);
                    controller.controllerS!
                        .animateCamera(CameraUpdate.newLatLng(
                      LatLng(
                        controller.position!.latitude,
                        controller.position!.longitude,
                      ),
                    ));
                  },
                  child: const Text('Go TO'),
                )
              ]);
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
