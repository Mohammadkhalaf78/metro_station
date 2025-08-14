import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:metro_station/nearest_station_helper.dart';
import 'package:get/get.dart';
import 'package:metro_station/station_list_screen.dart';
import 'package:metro_station/metro_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final nearestStationController = Get.put(NearestStationController());
  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final c = Get.put(MetroController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Align(
            child: Text(
              'Metro Station',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Autocomplete<String>(
                          optionsBuilder: (TextEditingValue text) {
                            if (text.text.isEmpty) {
                              return c.stations;
                            }
                            return c.stations.where(
                              (s) => s.toLowerCase().contains(
                                text.text.toLowerCase(),
                              ),
                            );
                          },
                          initialValue: TextEditingValue(
                            text: c.start.value ?? '',
                          ),
                          onSelected: (v) => c.setStart(v),
                          fieldViewBuilder:
                              (
                                context,
                                controller,
                                focus,
                                onSubmit,
                              ) {
                                controller.text =
                                    c.start.value ?? '';
                                return TextField(
                                  controller: controller,
                                  focusNode: focus,
                                  decoration: const InputDecoration(
                                    hintText: 'Select or type your station',
                                  ),
                                  onChanged: (v) => c.setStart(v),
                                );
                              },
                        ),
                      ),
                      IconButton(
                        tooltip: 'Find nearest on Google Maps',
                        onPressed: () async {
                          
                          String placeName = c.start.value?.trim() ?? "";
                          if (placeName.isEmpty) {
                            Get.snackbar("Error", "Please enter a place name");
                            return;
                          }
                          List<Location> locations = await locationFromAddress(
                            placeName,
                          );
                          double lat = locations.first.latitude;
                          double lng = locations.first.longitude;
                          String googleUrl =
                              'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=walking';
                          if (await canLaunchUrl(Uri.parse(googleUrl))) {
                            await launchUrl(Uri.parse(googleUrl));
                          } else {
                            Get.snackbar("Error", "Could not open Google Maps");
                          }
                          
                        },
                        icon: const Icon(Icons.map),
                      ),
                    ],
                  ),
                  SizedBox(height: 22),
                  Obx(() {
                    return Autocomplete<String>(
                      optionsBuilder: (TextEditingValue text) {
                        if (text.text.isEmpty) return c.stations;
                        return c.stations.where(
                          (s) =>
                              s.toLowerCase().contains(text.text.toLowerCase()),
                        );
                      },
                      initialValue: TextEditingValue(
                        text:
                            c.end.value ??
                            nearestStationController.nearestStation.value ??
                            '',
                      ),
                      onSelected: (v) => c.setEnd(v),
                      fieldViewBuilder: (context, controller, focus, onSubmit) {
                        // تحديث النص تلقائيًا عند تغير أقرب محطة
                        controller.text =
                            c.end.value ??
                            nearestStationController.nearestStation.value ??
                            '';

                        return TextField(
                          controller: controller,
                          focusNode: focus,
                          decoration: const InputDecoration(
                            hintText: 'Select or type end station',
                          ),
                          onChanged: (v) => c.setEnd(v),
                        );
                      },
                    );
                  }),

                  SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => c.compute(),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  Obx(() {
                    if (c.path.isEmpty) return const SizedBox.shrink();
                    return Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Trip details",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Count", style: TextStyle(fontSize: 18)),
                            Text(
                              "${c.stops.value}",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Time", style: TextStyle(fontSize: 18)),
                            Text(
                              "${c.etaMin.value} min",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Price", style: TextStyle(fontSize: 18)),
                            Text(
                              "${c.priceEg.value}",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      if (c.path.isEmpty) {
                        Get.snackbar(
                          'Validation',
                          'Please compute a route first',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return;
                      }
                      Get.to(
                        StationListScreen(
                          routeStations: c.path.toList(),
                          transferSteps: c.transfers.toList(),
                          stopsCount: c.stops.value,
                          estimatedMinutes: c.etaMin.value,
                          price: c.priceEg.value,
                        ),
                      );
                    },
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "More",
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Nearby",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  Align(
                    alignment: Alignment.topLeft,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.train, color: Colors.black, size: 22),
                      label: Text(
                        'Nearest Station',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 22),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Find by place name ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  SizedBox(height: 22),
                  TextField(
                    onChanged: (val) =>
                        nearestStationController.placeName.value = val,

                    decoration: InputDecoration(
                      hintText: 'Enter place name ',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 22),
                  Align(
                    alignment: Alignment.topLeft,
                    child: ElevatedButton(
                      onPressed: () =>
                          nearestStationController.findNearestStation(),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        alignment: Alignment.centerLeft,
                      ),
                      child: Text(
                        'Show',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
