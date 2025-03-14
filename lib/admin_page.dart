import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminMonitoringPage extends StatefulWidget {
  @override
  _AdminMonitoringPageState createState() => _AdminMonitoringPageState();
}

class _AdminMonitoringPageState extends State<AdminMonitoringPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Landslide Monitoring - Kollam & Idukki')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('landslide_data').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data available', style: TextStyle(fontSize: 18)));
          }

          List<DocumentSnapshot> data = snapshot.data!.docs;

          return ListView(
            children: data.map((doc) {
              // Ensure values exist and are valid
              String location = doc['location'] ?? 'Unknown';
              double temperature = (doc['temperature'] ?? 0).toDouble();
              double humidity = (doc['humidity'] ?? 0).toDouble();
              double rainfall = (doc['rainfall'] ?? 0).toDouble();
              int prediction = doc['prediction'] ?? 0; // 1 = Landslide, 0 = No Landslide

              return Card(
                margin: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(location, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text('🌡 Temperature: $temperature°C', style: TextStyle(fontSize: 16)),
                      Text('💧 Humidity: $humidity%', style: TextStyle(fontSize: 16)),
                      Text('🌧 Rainfall: $rainfall mm', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),
                      Text(
                        'Landslide Risk: ${prediction == 1 ? "⚠️ High Risk" : "✅ Low Risk"}',
                        style: TextStyle(fontSize: 18, color: prediction == 1 ? Colors.red : Colors.green, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),

                      // Line Chart
                      if (temperature > 0 || humidity > 0 || rainfall > 0)
                        SizedBox(
                          height: 180,
                          child: LineChart(
                            LineChartData(
                              gridData: FlGridData(show: true, drawVerticalLine: false),
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, _) => Text('${value.toInt()}'),
                                    reservedSize: 30,
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, _) {
                                      switch (value.toInt()) {
                                        case 1: return Text('Temp');
                                        case 2: return Text('Humidity');
                                        case 3: return Text('Rainfall');
                                        default: return Text('');
                                      }
                                    },
                                    reservedSize: 22,
                                  ),
                                ),
                              ),
                              borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey)),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: [
                                    FlSpot(1, temperature),
                                    FlSpot(2, humidity),
                                    FlSpot(3, rainfall),
                                  ],
                                  isCurved: true,
                                  barWidth: 4,
                                  color: Colors.blue, // Fixed color issue
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: Colors.blue.withOpacity(0.2), // Light area under curve
                                  ),
                                  dotData: FlDotData(show: true),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
