import 'package:flutter/material.dart';

class StationListScreen extends StatelessWidget {
  final List<String> routeStations;
  final List<String> transferSteps;
  final int stopsCount;
  final int estimatedMinutes;
  final int price;

  const StationListScreen({
    super.key,
    required this.routeStations,
    required this.transferSteps,
    required this.stopsCount,
    required this.estimatedMinutes,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Route'), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: routeStations.length,
              separatorBuilder: (_, __) => const Divider(height: 0),
              itemBuilder: (context, index) {
                final station = routeStations[index];
                return ListTile(
                  leading: Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(Icons.directions_subway_filled_rounded),
                    ),
                  ),
                  title: Text(station),
                  subtitle: _buildTransferNote(index),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Trip details', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Stops: $stopsCount'),
                Text('ETA: $estimatedMinutes min'),
                Text('Price: $price EGP'),
                const SizedBox(height: 8),
                if (transferSteps.isNotEmpty) const Text('Transfers:'),
                for (final step in transferSteps) Text('• $step'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget? _buildTransferNote(int index) {
    if (index == 0) return const Text('Start');
    if (index == routeStations.length - 1) return const Text('Destination');
    return null;
  }
}
