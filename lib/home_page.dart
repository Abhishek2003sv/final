import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:marquee/marquee.dart';
import 'package:my_flutter_app/prediction_page.dart';

class HomePage extends StatelessWidget {
  final List<String> newsList = [
    "Stay alert during heavy rains.",
    "Check landslide-prone areas before travel.",
    "Emergency helpline: 112.",
    "Use safe routes during bad weather",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 58, 223, 201),
                  Color.fromARGB(255, 124, 204, 224),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Content overlay
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 100),
                Center(
                  child: Text(
                    'Welcome to the Landslide Prediction App',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                
                // Buttons
                _buildButton(context, 'Landslide Prediction', Icons.warning, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PredictionPage()));
                }),
                _buildButton(context, 'Guidance', Icons.help, () {
                  // Replace with actual page
                }),
                _buildButton(context, 'Weather Forecasting', Icons.cloud, () {
                  // Replace with actual page
                }),
                _buildButton(context, 'Emergency Alerts', Icons.notifications, () {
                  // Replace with actual page
                }),
                _buildButton(context, 'Resource Requests', Icons.support, () {
                  // Replace with actual page
                }),
                _buildButton(context, 'Contact Us', Icons.feedback, () {
                  // Replace with actual page
                }),
              ],
            ),
          ),
        ],
      ),

      // Flash News Marquee at the Bottom
      bottomNavigationBar: Container(
        color: Colors.green,
        height: 50,
        child: Marquee(
          text: newsList.join("  •  "), // Separate news items with a bullet
          style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255), fontSize: 16, fontWeight: FontWeight.bold),
          scrollAxis: Axis.horizontal,
          blankSpace: 50.0,
          velocity: 50.0,
          pauseAfterRound: Duration(seconds: 1),
          startPadding: 10.0,
          accelerationDuration: Duration(seconds: 1),
          accelerationCurve: Curves.easeIn,
          decelerationDuration: Duration(seconds: 1),
          decelerationCurve: Curves.easeOut,
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label, IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 30),
        label: Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.white,
          foregroundColor: Color.fromARGB(255, 0, 131, 176),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          shadowColor: Colors.black26,
        ),
      ),
    );
  }
}
