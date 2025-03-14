
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/firebase_services.dart';
import 'package:my_flutter_app/prediction_page.dart';
import 'weather_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Package for animations
import 'admin_page.dart';
import 'package:geolocator/geolocator.dart';
import 'home_page.dart';
import 'login_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDI-iQiRatwDaMEnsJj6ku5kvUuEIM9ULw",
      appId: "1:248824650721:web:9965e6125459f1f6c450a0",
      messagingSenderId: "248824650721",
      projectId: "myflutterapp-f60b3",
      databaseURL: "https://myflutterapp-f60b3-default-rtdb.firebaseio.com",
    ),
  );
  runApp(LandslideApp());
}
class LandslideApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Landslide Prediction App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),
      home: LoginPage(),
    );
  }
}
class GuidancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Guidance',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color.fromARGB(255, 94, 190, 238),
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ClassicTile(
              title: 'Step 1: Stay Informed',
              description:
                  'Landslides often occur due to heavy rainfall, earthquakes, or human activities. Staying informed can help you anticipate risks.\n\nHow?\n- Monitor weather reports and warnings from government agencies.\n- Follow local disaster management authorities and news updates.\n- Use mobile alerts or apps that provide real-time weather and landslide risk notifications.',
            ),
            ClassicTile(
              title: 'Step 2: Prepare an Emergency Kit',
              description:
                  'In case of a landslide, roads may be blocked, power may be cut off, and essential services may be delayed.\n\nWhat to Include?\n- Water: At least three days’ supply for each person.\n- Food: Non-perishable items like canned food, energy bars, and dry fruits.\n- Flashlight & Batteries: For visibility in case of power outages.\n- First Aid Kit: Bandages, antiseptics, necessary medications.\n- Important Documents: IDs, insurance papers, emergency contacts, and maps.\n- Clothing & Blanket: To stay warm and dry.',
            ),
            ClassicTile(
              title: 'Step 3: Plan Evacuation',
              description:
                  'Knowing escape routes and safe zones can save lives during an emergency.\n\nHow?\n- Identify and mark safe areas (higher ground away from slopes).\n- Plan multiple escape routes in case roads are blocked.\n- Discuss the evacuation plan with family or community members.\n- Keep emergency contacts ready and inform loved ones about your plans.',
            ),
          ],
        ),
      ),
    );
  }
}

class ClassicTile extends StatelessWidget {
  final String title;
  final String description;

  const ClassicTile({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        backgroundColor: Colors.grey.shade100,
        collapsedBackgroundColor: Colors.white,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 112, 195, 233),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class WeatherForecastingPage extends StatefulWidget {
  @override
  _WeatherForecastingPageState createState() => _WeatherForecastingPageState();
}

class _WeatherForecastingPageState extends State<WeatherForecastingPage> {
  final WeatherService weatherService = WeatherService();
  String city = 'London';
  Map<String, dynamic>? weatherData;
  bool isLoading = false;

  void fetchWeather() async {
    setState(() {
      isLoading = true;
    });

    try {
      final data = await weatherService.fetchWeather(city);
      setState(() {
        weatherData = data;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecasting'),
        backgroundColor: const Color.fromARGB(255, 144, 233, 233),  // You can set your primary blue color here.
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter City',
              ),
              onChanged: (value) {
                city = value;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchWeather,
              child: Text('Get Weather'),
            ),
            SizedBox(height: 20),
            if (isLoading)
              Center(child: CircularProgressIndicator())
            else if (weatherData != null)
              ...[
                Text(
                  'Weather in ${city}',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                _buildWeatherTile(
                  title: 'Temperature',
                  value:
                      '${weatherData!["main"]["temp"]}°C (Feels like ${weatherData!["main"]["feels_like"]}°C)',
                ),
                _buildWeatherTile(
                  title: 'Humidity',
                  value: '${weatherData!["main"]["humidity"]}%',
                ),
                _buildWeatherTile(
                  title: 'Wind Speed',
                  value: '${weatherData!["wind"]["speed"]} m/s',
                ),
                _buildWeatherTile(
                  title: 'Cloudiness',
                  value: '${weatherData!["clouds"]["all"]}%',
                ),
                _buildWeatherTile(
                  title: 'Weather Description',
                  value: weatherData!["weather"][0]["description"],
                ),
                _buildWeatherTile(
                  title: 'Pressure',
                  value: '${weatherData!["main"]["pressure"]} hPa',
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: fetchWeather,
                  child: Text('Refresh'),
                ),
              ]
            else
              Center(child: Text('No data available')),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherTile({required String title, required String value}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }
}

class EmergencyAlertsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Alerts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Emergency Alerts',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.warning, color: Colors.red),
                    title: Text('Alert ${index + 1}: Landslide Risk in Area'),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle push notification settings
              },
              child: Text('Manage Notifications'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> with SingleTickerProviderStateMixin {
  final FirebaseServices firebaseServices = FirebaseServices();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    nameController.dispose();
    emailController.dispose();
    feedbackController.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    return email.contains('@') && email.contains('.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 149, 226, 220),
        elevation: 4.0,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'We value your feedback!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 120, 216, 219),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  prefixIcon: Icon(Icons.person, color: const Color.fromARGB(255, 121, 225, 233)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Your Email',
                  prefixIcon: Icon(Icons.email, color: const Color.fromARGB(255, 140, 214, 236)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              TextField(
                controller: feedbackController,
                decoration: InputDecoration(
                  labelText: 'Your Feedback',
                  prefixIcon: Icon(Icons.feedback, color: const Color.fromARGB(255, 136, 199, 228)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  final name = nameController.text.trim();
                  final email = emailController.text.trim();
                  final feedback = feedbackController.text.trim();

                  if (name.isEmpty || email.isEmpty || feedback.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill out all fields.')),
                    );
                  } else if (!isValidEmail(email)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter a valid email address.')),
                    );
                  } else {
                    await firebaseServices.addFeedback(name, email, feedback);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Thank you for your feedback!')),
                    );
                    nameController.clear();
                    emailController.clear();
                    feedbackController.clear();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 127, 218, 210),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  'Submit Feedback',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ResourceRequestsPage extends StatefulWidget {
  @override
  _ResourceRequestsPageState createState() => _ResourceRequestsPageState();
}

class _ResourceRequestsPageState extends State<ResourceRequestsPage> {
  final TextEditingController _requestController = TextEditingController();
  final String recipientPhoneNumber = '+917736253719';
  final DatabaseReference _database = FirebaseDatabase.instance.ref("resource_requests");
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _updateUserLocation();
  }

  /// ✅ Get and store user's location
  Future<void> _updateUserLocation() async {
    try {
      Position position = await _getCurrentLocation();
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print("Location error: $e");
    }
  }

  /// ✅ Get current location using Geolocator
  Future<Position> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  /// ✅ Store request in Firebase and send WhatsApp message
  Future<void> _sendWhatsAppMessage(BuildContext context, String requestDetails) async {
    if (_currentPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location not available. Please try again.')),
      );
      return;
    }

    // ✅ Store request in Firebase
    String requestId = _database.push().key ?? "request_${DateTime.now().millisecondsSinceEpoch}";
    await _database.child(requestId).set({
      'request': requestDetails,
      'latitude': _currentPosition!.latitude,
      'longitude': _currentPosition!.longitude,
      'timestamp': DateTime.now().toIso8601String(),
    });

    // ✅ Prepare WhatsApp message with location
    String locationMessage = "\nLocation: https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude},${_currentPosition!.longitude}";
    final url = Uri.parse('https://wa.me/$recipientPhoneNumber?text=${Uri.encodeComponent(requestDetails + locationMessage)}');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open WhatsApp. Please ensure it is installed.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resource Requests')
            .animate()
            .flip(duration: 1.seconds), // Animation only on text
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 10,
        shadowColor: Colors.tealAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Request Resources via WhatsApp',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ).animate().scale(duration: 1.seconds, curve: Curves.easeOutBack),
            SizedBox(height: 20),
            TextField(
              controller: _requestController,
              decoration: InputDecoration(
                labelText: 'Enter Your Request',
                labelStyle: TextStyle(fontSize: 18, color: Colors.teal),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.teal, width: 2),
                ),
                prefixIcon: Icon(Icons.edit, color: Colors.teal),
              ),
              maxLines: 5,
            ).animate().flip(duration: 1.seconds, delay: 300.ms),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  String requestDetails = _requestController.text.trim();
                  if (requestDetails.isNotEmpty) {
                    _sendWhatsAppMessage(context, requestDetails);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter the request details.')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 8,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.send),
                    SizedBox(width: 10),
                    Text('Send Request', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ).animate().scale(duration: 1.seconds, curve: Curves.elasticOut),
            ),
          ],
        ).animate().scale(duration: 1.seconds),
      ),
    );
  }
}
