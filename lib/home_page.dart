import 'package:flutter/material.dart';

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
            child: Column(
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
              SizedBox(height: 22,),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
