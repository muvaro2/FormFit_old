import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'dart:typed_data';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:io';
import 'dart:math';

void main() {
  runApp(MyApp());
}

List<List<double>> globalRepetition = [];
const List<List<double>> globalCalibration = [[-0.8569981038570404, -0.5429370146244764, 1.1824060142040254, 8.600462818145752, -5.7364932775497435, -0.2890529714524746], [-0.7674691684735127, -0.7271081763009231, 1.307324035045428, 8.124541061352462, -6.593383026123047, -0.9189972444413564], [-0.7004791699731961, -0.9044760342591847, 1.4137445996969173, 7.305345859283056, -7.355822215936124, -1.8346675912539165], [-0.6439518009813932, -1.0824602448023284, 1.5099648879124568, 6.130867239145132, -7.966295748490552, -2.9157510812465963], [-0.5767621216674644, -1.273974711696307, 1.594218852581122, 4.6227723137690475, -8.242530255439954, -3.7116545874338884], [-0.4302413959008378, -1.4193614293367436, 1.6209986350475212, 2.948362434292451, -8.340548459077493, -4.3288846590580095], [-0.38941836785525086, -1.5205680860922886, 1.6010049315599293, 1.2800543044622128, -8.123140580837545, -4.599874846751874], [-0.38808307089866734, -1.5474339994100426, 1.5389535492811448, -0.5604236225287121, -7.75825349000784, -4.769487692148258], [-0.4068526881245466, -1.5282978730323988, 1.4420585756118482, -2.309119863387866, -7.3479871811010895, -4.733699675706717], [-0.3712462989183572, -1.4363826311551606, 1.2848257935964145, -3.6984847013766946, -6.6350028001345125, -4.252496741368219], [-0.283117241355089, -1.3295920232931773, 1.1197390586901932, -5.038750819059518, -5.948666104903587, -3.867474737534156], [-0.18911408533652624, -1.2174395092022725, 0.9910638249837437, -6.2705852264013044, -5.481818593465365, -3.4059974911885385], [-0.1839103746586121, -1.1213289013275733, 0.9077927415187542, -7.283406989391034, -4.885752573380104, -2.726552379647126], [-0.14357878205676872, -0.9638079226016998, 0.7846614867448807, -7.897192080815633, -4.202693819999696, -2.1264815792441367], [-0.053307000261086625, -0.7479555497566859, 0.636740463360762, -8.262586942085852, -3.7670666908606507, -1.6238354401901745], [-0.051901226118207036, -0.5285323455571556, 0.4887133264770875, -8.697468625582182, -3.308850391094501, -1.3084276295052126], [-0.07372869276561025, -0.3528482903009997, 0.3654618715628598, -8.966909704452906, -3.11444580982893, -0.9882403636781071], [-0.05622192111152859, -0.20434812693259657, 0.2604795943754606, -9.106912918579884, -2.90527935333741, -0.7903355295172869], [0.05274586444810179, -0.003987068797533239, 0.14345465762397414, -9.165951090592603, -2.6358321776756872, -0.7308278681280521], [0.06310316121014647, 0.21815446474804312, -0.06596991956377239, -9.090883969037963, -2.6053651586557045, -0.7323433159158015], [0.07406897810884765, 0.39216529522568766, -0.28585242873583094, -9.068606119889479, -2.8003326431298863, -0.9674197239753528], [0.11916806740829577, 0.5400870942439024, -0.46088137165285065, -8.957425719041092, -3.0550179343957167, -1.3637248243276887], [0.24387893942304145, 0.6594243155075954, -0.5302126199007035, -8.610273229158842, -3.652988909146724, -1.833405254284541], [0.2737428100612492, 0.7622642533901411, -0.6284033314539835, -8.177561822304359, -4.220383958938795, -2.248546179288473], [0.2680782103266281, 0.8610309779644012, -0.7386300478990262, -7.727413668999307, -4.580492991667528, -2.7758215464078466], [0.3031105478031513, 0.9270776718090742, -0.8616191345911759, -7.042730571062137, -5.201637494258393, -3.309700223115775], [0.369945078343153, 0.9642100632190704, -0.9670149226983389, -6.2007208665212, -6.0114883581797285, -3.796452538172403], [0.3898025003190224, 0.9816369377649746, -1.0702652555245618, -5.234598820026104, -6.614695937816914, -4.085855243756221], [0.3686438492666452, 1.0030172147811989, -1.1825974933612042, -4.209887717014704, -6.693178928815402, -4.371777477631202], [0.3662101845137584, 1.0112795698337067, -1.2630417943000793, -2.821599648510797, -7.57739593187968, -4.411251437969698], [0.4017179005994248, 1.0012527717993809, -1.354708786194141, -1.3666008913746246, -8.301681907360372, -4.428493699660668], [0.45501236193455197, 0.9779337576184519, -1.4215358795263828, -0.027960740048915945, -8.456493040231557, -4.299301161674354], [0.36225208539802295, 0.9334647201956845, -1.437814260751773, 1.419681691693573, -8.720918393746402, -3.938554028364328], [0.30029899839025287, 0.9166678850467388, -1.4282534204996549, 2.8055937904004877, -8.591756629943848, -3.6430450870440554], [0.47674272303015763, 0.9144601581952511, -1.4318857266352727, 4.187904313741588, -8.160615817094461, -3.1659667284060746], [0.6241617341072132, 0.8848570890151537, -1.409032327395219, 5.438678731673803, -8.055986419090857, -2.4108301897843676], [0.642217892408371, 0.821250762962378, -1.381360142964583, 6.575881675573496, -7.55537420786344, -1.7568150228032695], [0.60484664722895, 0.667628327776224, -1.262502212096483, 7.55686246554057, -6.837878794547838, -0.9429577448429196], [0.5720862545526753, 0.5483470942920601, -1.16329534023236, 8.169935896457769, -6.1386975428996955, -0.23562095449903148], [0.55332171889022, 0.4835914634168148, -1.1008096754550933, 8.550333213806152, -5.387021374702454, 0.2763710256665945]];
final StreamController<List<double>> sensorDataController = StreamController.broadcast();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wearable Device App',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue[900]!) //**change this color to anything**
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
        title: Text(
          'FormFit',
          style: GoogleFonts.audiowide(fontWeight: FontWeight.w800,fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: 80,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Keeps the content centered
          children: [
            Text(
              'Welcome to FormFit!', // we can change what text is displayed here later
              style: GoogleFonts.signikaNegative(fontWeight: FontWeight.w400,fontSize: 50,),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20), // Space between text and button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BluetoothPage()),
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
//--------------------scan page--------------------------------------------//
class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  StreamSubscription<List<ScanResult>>? scanSubscription;
  BluetoothDevice? connectedDevice;
  final List<BluetoothDevice> devicesList = [];

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _startScan();
  }

  Future<void> _requestPermissions() async {
    await Permission.location.request();
    // For Android 12+ you might also need:
    // await Permission.bluetoothScan.request();
    // await Permission.bluetoothConnect.request();
  }

  void _startScan() {
    devicesList.clear();
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    scanSubscription = FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult r in results) {
        if (r.device.name == "FormFit") {
          if (!devicesList.contains(r.device)) {
            setState(() {
              devicesList.add(r.device);
            });
          }
        }
      }
    });
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    await BLEManager.instance.connectToDevice(device);
    setState(() {
      connectedDevice = device;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Connected to ${device.name}")),
    );
  }

  @override
  void dispose() {
    scanSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan & Connect")),
      body: ListView.builder(
        itemCount: devicesList.length,
        itemBuilder: (context, index) {
          BluetoothDevice device = devicesList[index];
          return ListTile(
            title: Text(device.name),
            subtitle: Text(device.id.toString()),
            onTap: () => _connectToDevice(device),
          );
        },
      ),
    );
  }
}
//--------------------------------end of scan page---------------//

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({super.key});

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FormFit',
          style: GoogleFonts.audiowide(fontWeight: FontWeight.w800,fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: 80,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Connect to the device via Bluetooth",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ExerciseSelectionPage()),
                );
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseSelectionPage extends StatelessWidget {
  const ExerciseSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FormFit',
          style: GoogleFonts.audiowide(fontWeight: FontWeight.w800,fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: 80,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Select an Exercise:",
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BicepCurlPage()),
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
        title: Text(
          'FormFit',
          style: GoogleFonts.audiowide(fontWeight: FontWeight.w800,fontSize: 40),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: 80,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Selected Exercise: Bicep Curl",
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {}, child: const Text('Read Instructions')),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {}, child: const Text('Start Exercise')),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChartPage()),
                  );
                },
                child: const Text("Data Chart")),
          ],
        ),
      ),
    );
  }
}

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  List<ChartData> chartData = [];
  int xValue = 0;
  StreamSubscription? sensorSubscription;

  bool isPlotting = true;
  bool isRecording = false;
  // Local list for recording during the session.
  List<List<double>> currentRepetition = [];

  @override
  void initState() {
    super.initState();
    sensorSubscription = sensorDataController.stream.listen((data) {
      // Append full sensor data (6 values) when recording.
      if (isRecording) {
        currentRepetition.add(List<double>.from(data));
      }
      // Plot accelerometer values (indices 3, 4, 5) if plotting is enabled.
      if (isPlotting) {
        setState(() {
          chartData.add(ChartData(xValue, data[3], data[4], data[5]));
          if (chartData.length > 50) {
            chartData.removeAt(0);
          }
          xValue++;
        });
      }
    });
  }

  @override
  void dispose() {
    sensorSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sensor Data Chart"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text("Plotting")),
          ),
          Switch(
            value: isPlotting,
            onChanged: (value) {
              setState(() {
                isPlotting = value;
                if (isPlotting) {
                  sensorSubscription?.resume();
                } else {
                  sensorSubscription?.pause();
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Recording button placed in the body above the chart.
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  if (isRecording) {
                    // When stopping recording, store current data into the global variable.
                    globalRepetition = List<List<double>>.from(currentRepetition);
                  } else {
                    // When starting a new recording, clear the local repetition data.
                    currentRepetition.clear();
                  }
                  isRecording = !isRecording;
                });
              },
              child: Text(isRecording ? "Stop Recording" : "Start Recording"),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SfCartesianChart(
                primaryXAxis: NumericAxis(),
                primaryYAxis: NumericAxis(),
                legend: Legend(isVisible: true),
                series: <ChartSeries>[
                  LineSeries<ChartData, int>(
                    name: 'Acc X',
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.accX,
                    color: Colors.red,
                  ),
                  LineSeries<ChartData, int>(
                    name: 'Acc Y',
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.accY,
                    color: Colors.green,
                  ),
                  LineSeries<ChartData, int>(
                    name: 'Acc Z',
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.accZ,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  final int x;
  final double accX;
  final double accY;
  final double accZ;
  ChartData(this.x, this.accX, this.accY, this.accZ);
}

class BLEManager {
  static final BLEManager _instance = BLEManager._internal();
  static BLEManager get instance => _instance;
  BLEManager._internal();

  BluetoothDevice? connectedDevice;
  BluetoothCharacteristic? sensorCharacteristic;

  Future<void> connectToDevice(BluetoothDevice device) async {
    await device.connect();
    connectedDevice = device;
    List<BluetoothService> services = await device.discoverServices();
    for (var service in services) {
      if (service.uuid.toString().toLowerCase() ==
          "12345678-1234-5678-1234-56789abcdef0") {
        for (var c in service.characteristics) {
          if (c.uuid.toString().toLowerCase() ==
              "12345678-1234-5678-1234-56789abcdef1") {
            sensorCharacteristic = c;
            await sensorCharacteristic!.setNotifyValue(true);
            sensorCharacteristic!.value.listen((value) {
              if (value.length >= 24) {
                ByteData byteData = ByteData.sublistView(Uint8List.fromList(value));
                List<double> sensorValues = [];
                for (int i = 0; i < 6; i++) {
                  sensorValues.add(byteData.getFloat32(i * 4, Endian.little));
                }
                sensorDataController.add(sensorValues);
              }
            });
          }
        }
      }
    }
  }

  Future<void> disconnect() async {
    if (connectedDevice != null) {
      await connectedDevice!.disconnect();
      connectedDevice = null;
    }
  }
}