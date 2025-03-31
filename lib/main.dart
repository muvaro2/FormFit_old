import 'constants.dart';
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FormFit',
      theme: ThemeData(
        fontFamily: "Cairo",
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
      ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                pColor.withOpacity(0.75),
                pColor,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )
        ),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.all(45),
                child: Image.asset(
                  "assets/images/lined heart.png",
                  color: wColor,
                )
            ),
            SizedBox(height: 50),
            Text(
              "FormFit",
              style: TextStyle(
                color: wColor,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                wordSpacing: 2,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Use your wearable device today",
              style: TextStyle(
                color: wColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 60),
            Material(
              color: wColor,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => HomeScreen()
                  ));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      color: pColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 80,
        color: Color(0xFFD1E5F4),
        child: Column(
          children: [
            Divider(color: Color(0xFFAEADB2), height: 10.0, indent: 10, endIndent: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                BottomNavItem(
                    icon: (Icons.home),
                    isActive: true,
                    press: "Home"
                ),
                BottomNavItem(
                  icon: Icons.fitness_center,
                  press: "Workouts",
                ),
                BottomNavItem(
                  icon: Icons.bluetooth,
                  press: "Bluetooth",
                ),
              ],
            ),
          ],
        )
    );
  }
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFD1E5F4),
      bottomNavigationBar: BottomNavBar(),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * 0.35,
            decoration: BoxDecoration(
                color: aColor,
                image: DecorationImage(
                  alignment: Alignment.centerLeft,
                  image: AssetImage(
                      "assets/images/background_texture.png"),
                  fit: BoxFit.fill,
                )
            ),
          ),
          SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        "FormFit",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 50,
                        )
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 40),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.5),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: "Search",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                        "Recommended Workouts",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: bColor.withOpacity(0.7),
                        )
                    ),
                    SizedBox(height: 30),
                    WorkoutsSection(),
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}

class WorkoutsSection extends StatelessWidget {
  const WorkoutsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 260,
                width: 200,
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => BicepCurlPage(),
                            ));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            child: Image.asset(
                              "assets/images/workout${index + 1}.jpg",
                              height: 180,
                              width: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                              margin: EdgeInsets.all(8),
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: Color(0xFFF2F8FF),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                  )
                                ],
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.favorite_outline,
                                  color: pColor,
                                  size: 28,
                                ),
                              )
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            workouts[index],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: pColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD1E5F4),
      bottomNavigationBar: BottomNavBar(),
      body: Column(
        children: [
          Container(
            child: Text(
                "FormFit",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                  color: pColor,
                )
            ),
          ),
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.all(40),
            height: 100,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(13),
            ),
          )
        ],
      ),
    );
  }
}

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
    _adapterStateStateSubscription =
        FlutterBluePlus.adapterState.listen((state) {
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

class BluetoothAdapterStateObserver extends NavigatorObserver {
  StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name == '/DeviceScreen') {
      _adapterStateSubscription ??=
          FlutterBluePlus.adapterState.listen((state) {
            //listen to Bluetooth state changes
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

class BicepCurlPage extends StatelessWidget {
  const BicepCurlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.1,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/workout1.jpg"),
                          fit: BoxFit.fitHeight,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )
                    ),
                    child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                pColor.withOpacity(0.7),
                                pColor.withOpacity(0),
                                pColor.withOpacity(0),
                                pColor.withOpacity(0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 30, left: 10, right: 10),
                              child: Text(
                                  "FormFit",
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.w900,
                                    color: pColor,
                                  )
                              ),
                            ),
                            SizedBox(
                                height: 80,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 30),
                                        // Text(
                                        //   "Time",
                                        //   style: TextStyle(
                                        //     fontSize: 30,
                                        //     fontWeight: FontWeight.bold,
                                        //     color: Colors.black,
                                        //   )
                                        // )
                                      ],
                                    )
                                  ],
                                )
                            )
                          ],
                        )
                    )
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Bicep Curl",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue[900],
                          )
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          SizedBox(width: 5),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Description:",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 200),
                      Material(
                          color: pColor,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => HomeScreen()
                                ));
                              },
                              child: Container(
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                      child: Text(
                                          "Start Exercise",
                                          style: TextStyle(
                                            color: wColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          )
                                      )
                                  )
                              )
                          )
                      )
                    ],
                  ),
                )
              ],
            )
        )
    );
  }
}



class BottomNavItem extends StatelessWidget {
  final IconData? icon;
  final String? press;
  final bool isActive;

  const BottomNavItem({
    Key? key,
    this.icon,
    this.press,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (press == "Home") {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => HomeScreen()
          ));
        } else if (press == "Workouts") {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => WorkoutPage()
          ));
        } else {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => FlutterBluePage()
          ));
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(icon, size: 50, color: isActive ? kActiveIconColor : kTextColor),
        ],
      ),
    );
  }
}