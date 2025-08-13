import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metro_station/metro_data.dart';

class MetroController extends GetxController {
  final List<String> stations = getAllStations();

  final RxnString start = RxnString();
  final RxnString end = RxnString();

  final RxList<String> path = <String>[].obs;
  final RxList<String> transfers = <String>[].obs;
  final RxInt stops = 0.obs;
  final RxInt etaMin = 0.obs;
  final RxInt priceEg = 0.obs;

  void setStart(String? v) => start.value = v;
  void setEnd(String? v) => end.value = v;

  String? validate() {
    if ((start.value == null || start.value!.trim().isEmpty) &&
        (end.value == null || end.value!.trim().isEmpty)) {
      return 'Please choose start and end stations';
    }
    if (start.value == null || start.value!.trim().isEmpty) {
      return 'Please choose a start station';
    }
    if (end.value == null || end.value!.trim().isEmpty) {
      return 'Please choose an end station';
    }
    if (start.value == end.value) {
      return 'Start and end must be different';
    }
    if (!stations.contains(start.value)) {
      return 'Unknown start station';
    }
    if (!stations.contains(end.value)) {
      return 'Unknown end station';
    }
    return null;
  }

  bool compute() {
    final error = validate();
    if (error != null) {
      Get.snackbar('Validation', error, snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    final route = computeRouteSimple(start.value!, end.value!);
    if (route.isEmpty) {
      Get.snackbar('Route', 'No route found', snackPosition: SnackPosition.BOTTOM);
      return false;
    }
    path.assignAll(route);
    stops.value = route.isEmpty ? 0 : route.length - 1;
    etaMin.value = estimateMinutes(stops.value);
    priceEg.value = estimatePrice(stops.value);
    transfers.assignAll(buildTransferSteps(route));
    Get.snackbar(
      'Success',
      'Route found',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(12),
      borderRadius: 8,
    );
    return true;
  }
}


