import 'package:flutter/material.dart';

class StationListScreen extends StatelessWidget {
  const StationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stations'), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
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
                  title: Text('Station $index'),
                  onTap: () {
                    // Action when tapped
                  },
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            color: Colors.grey[300],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text('Trip Details')],
            ),
          ),
        ],
      ),
    );
  }
}
