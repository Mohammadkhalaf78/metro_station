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
                DropdownMenu(
                  hintText: "Select your station",
                  width: double.infinity,
                  dropdownMenuEntries: [
                    DropdownMenuEntry(value: "hello", label: "Hello"),
                    DropdownMenuEntry(value: "world", label: "World"),
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
                ElevatedButton(
                  style:ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    
                  ),
                  onPressed: () {}, child: Text('sump')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
