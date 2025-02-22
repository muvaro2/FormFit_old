
import 'package:flutter/material.dart';

import 'dart:math';
import 'package:real_time_chart/real_time_chart.dart';

class DataChartPage extends StatefulWidget {
  const DataChartPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DataChartPage> createState() => _DataChartPageState();
}

class _DataChartPageState extends State<DataChartPage> {
  @override
  Widget build(BuildContext context) {
    final stream = positiveDataStream();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        // backgroundColor: Color(0xFF5252FF),
      ),
      body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: RealTimeGraph(
                        stream: stream,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: RealTimeGraph(
                        stream: stream,
                        displayMode: ChartDisplay.points,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Supports negative values :',
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: RealTimeGraph(
                        stream: stream.map((value) => value - 150),
                        supportNegativeValuesDisplay: true,
                        xAxisColor: Colors.black12,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: RealTimeGraph(
                        stream: stream.map((value) => value - 150),
                        supportNegativeValuesDisplay: true,
                        displayMode: ChartDisplay.points,
                        xAxisColor: Colors.black12,
                      ),
                    ),
                  ),
                ],
              )
          )
      ),
    );
  }

  Stream<double> positiveDataStream() {
    return Stream.periodic(const Duration(milliseconds: 500), (_) {
      return Random().nextInt(300).toDouble();
    }).asBroadcastStream();
  }
}