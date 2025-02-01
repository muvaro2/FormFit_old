import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WearableDeviceHomepage(),
    );
  }
}

class WearableDeviceHomepage extends StatelessWidget {
  const WearableDeviceHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('Wearable Device for Sports Optimization and Injury Prevention'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Keeps the content centered
          children: [
            const Text(
              'Welcome to EOH Project Number {}!', // we can change what text is displayed here later
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20), // Space between text and button
            ElevatedButton(
              onPressed: () {
                // Action when button is clicked
                debugPrint('clicked');
                // we will have to change this later to take the user
                // to a different page
              },
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
