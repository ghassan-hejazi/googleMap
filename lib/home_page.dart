import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map/google_map_page.dart';
import 'package:google_map/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text('${controller.position!.latitude}'),
                    const SizedBox(height: 16),
                    Text('${controller.position!.longitude}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(const GoogleMapPage());
                      },
                      child: const Text('Go To Google Map'),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
