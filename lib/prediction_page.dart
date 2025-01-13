import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // For location

class PredictionPage extends StatefulWidget {
  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  late String location;
  double rainfall = 40.0;  // Simulated rainfall data
  double slope = 25.0;     // Simulated slope data
  String predictionResult = '';
  bool isLoading = false;

  // Function to get the user's current location
  Future<void> getRealTimeLocation() async {
    setState(() {
      isLoading = true;
    });

    try {
      Position position = await getCurrentLocation();
      setState(() {
        location = "Lat: ${position.latitude}, Long: ${position.longitude}";
        predictionResult = predictLandslide(position, rainfall, slope);
      });
    } catch (e) {
      setState(() {
        location = "Unable to get location: $e";
        predictionResult = '';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Function to get the user's current location
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check if the app has permission to access the device's location
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Get the current position of the user
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  // Simulate a landslide prediction
  String predictLandslide(Position position, double rainfall, double slope) {
    if (rainfall > 50 && slope > 30) {
      return 'High risk of landslide in Lat: ${position.latitude}, Long: ${position.longitude} due to high rainfall and steep slope.';
    } else if (rainfall > 30 && slope > 20) {
      return 'Moderate risk of landslide in Lat: ${position.latitude}, Long: ${position.longitude} due to moderate rainfall and slope.';
    } else {
      return 'Low risk of landslide in Lat: ${position.latitude}, Long: ${position.longitude}.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Landslide Prediction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter Details for Prediction',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: getRealTimeLocation,
              child: Text('Get Location & Predict'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            if (isLoading) CircularProgressIndicator(),
            if (location.isNotEmpty)
              Text(
                'Location: $location',
                style: TextStyle(fontSize: 18),
              ),
            SizedBox(height: 20),
            if (predictionResult.isNotEmpty)
              Text(
                'Prediction: $predictionResult',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
