import 'package:flutter/material.dart';

class StationsPage extends StatelessWidget {
  const StationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stations", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          SizedBox(height: 16,),
          Card(
            color: Colors.grey[50],
            child: ListTile(
              leading: Icon(Icons.train, size: 40),
              title: Text(
                "Halawn Station",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Handle tap
              },
            ),
          ),
                    SizedBox(height: 8,),
      
          Card(
                        color: Colors.grey[50],

            child: ListTile(
              leading: Icon(Icons.train, size: 40),
              title: Text(
                "Halawn Station",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Handle tap
              },
            ),
          ),
        
        ],
      ),
    );
  }
}
