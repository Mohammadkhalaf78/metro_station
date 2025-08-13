import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:metro_station/stations_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                        child: DropdownMenu(
                          width: double.infinity,
                          hintText: "Select your station",

                          dropdownMenuEntries: [
                            DropdownMenuEntry(value: "hello", label: "Hello"),
                            DropdownMenuEntry(value: "world", label: "World"),
                          ],
                        ),
                      ),
                      IconButton(
                        tooltip: 'Find nearest on Google Maps',
                        onPressed: () {},
                        icon: const Icon(Icons.map),
                      ),
                    ],
                  ),
                  SizedBox(height: 22),
                  DropdownMenu(
                    hintText: "Select end station",
                    width: double.infinity,
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: "hello", label: "Hello"),
                      DropdownMenuEntry(value: "world", label: "World"),
                    ],
                  ),
                  SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // خلفية زرقاء
                        foregroundColor: Colors.white, // نص أبيض
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // زوايا ناعمة
                        ),
                      ),
                      onPressed: () {
                        // TODO: حط الأكشن هنا
                      },
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Trip datails ",
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
                      Text("7", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Time", style: TextStyle(fontSize: 18)),
                      Text("30 min", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Sale", style: TextStyle(fontSize: 18)),
                      Text("10", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(StationsPage());
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
                    decoration: InputDecoration(
                      hintText: 'Enter place name ',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 22),

                  Align(
                    alignment: Alignment.topLeft,
                    child: ElevatedButton(
                      onPressed: () {
                        // Action
                      },
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
