import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'dart:async';
import 'screens/bluetooth_off_screen.dart';
import 'screens/scan_screen.dart';
import 'screens/data_chart_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wearable Device App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent) //**change this color to anything**
      ),
      debugShowCheckedModeBanner: false,
      home: WearableDeviceHomepage(),
    );
  }
}

class WearableDeviceHomepage extends StatefulWidget {
  const WearableDeviceHomepage({super.key});

  @override
  State<WearableDeviceHomepage> createState() => _WearableDeviceHomepageState();
}

class _WearableDeviceHomepageState extends State<WearableDeviceHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wearable Device for Exercise Optimization and Injury Prevention'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Keeps the content centered
          children: [
            const Text(
              'Welcome to EOH Project Number _!', // we can change what text is displayed here later
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20), // Space between text and button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BluetoothPage()),
                );
              },
              child: const Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}

class BluetoothPage extends StatelessWidget {
  const BluetoothPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect to the Device via Bluetooth'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FlutterBluePage()),
                );
              },
              child: const Text('Click here to verify your Bluetooth Connection'),
            ),
            const SizedBox(height: 40), // Space between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ExerciseSelectionPage()),
                );
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
} // Added new page class

class FlutterBluePage extends StatefulWidget {
  const FlutterBluePage({super.key});

  @override
  State<FlutterBluePage> createState() => _FlutterBluePageState();
}

class _FlutterBluePageState extends State<FlutterBluePage> {

  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;

  late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

  @override
  void initState() {
    super.initState();
    _adapterStateStateSubscription = FlutterBluePlus.adapterState.listen((state) {
      _adapterState = state;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _adapterStateStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget screen = _adapterState == BluetoothAdapterState.on
        ? const ScanScreen()
        : BluetoothOffScreen(adapterState: _adapterState);

    return MaterialApp(
      color: Colors.lightBlue,
      home: screen,
      navigatorObservers: [BluetoothAdapterStateObserver()],
      debugShowCheckedModeBanner: false,
    );
  }
}

class BluetoothAdapterStateObserver extends NavigatorObserver{
  StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name == '/DeviceScreen') {
      _adapterStateSubscription ??= FlutterBluePlus.adapterState.listen((state) {  //listen to Bluetooth state changes
        if (state != BluetoothAdapterState.on) {
          navigator?.pop(); //exit if Bluetooth is off
        }
      });
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _adapterStateSubscription?.cancel();
    _adapterStateSubscription = null;
  }

}

class ExerciseSelectionPage extends StatelessWidget {
  const ExerciseSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select an exercise'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BicepCurlPage()),
                );
              },
              child: const Text('Bicep Curl'),
            ),
          ],
        ),
      ),
    );
  }
}

class BicepCurlPage extends StatelessWidget {
  const BicepCurlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bicep Curl'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
                onPressed: () {

                },
                child: const Text('Read Instructions')
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {

                },
                child: const Text('Start Exercise')
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DataChartPage(title: "Real-Time Chart")),
                  );
                },
                child: const Text("Data Chart")
            ),
          ],
        ),
      ),
    );
  }
}
