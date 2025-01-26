
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
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
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Package for animations



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
      title: 'Landslide Prediction App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GuidancePage()));
                }),
                _buildButton(context, 'Weather Forecasting', Icons.cloud, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherForecastingPage()));
                }),
                _buildButton(context, 'Emergency Alerts', Icons.notifications, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EmergencyAlertsPage()));
                }),
                _buildButton(context, 'Resource Requests', Icons.support, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ResourceRequestsPage()));
                }),
                _buildButton(context, 'Contact Us', Icons.feedback, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage()));
                }),
              ],
            ),
          ),
        ],
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


class GuidancePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Guidance',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 128, 231, 226),
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            AnimatedTile(
              title: 'Step 1: Stay Informed',
              description: 'Landslides often occur due to heavy rainfall, earthquakes, or human activities. Staying informed can help you anticipate risks.\n\nHow?\n- Monitor weather reports and warnings from government agencies.\n- Follow local disaster management authorities and news updates.\n- Use mobile alerts or apps that provide real-time weather and landslide risk notifications.',
            ),
            AnimatedTile(
              title: 'Step 2: Prepare an Emergency Kit',
              description: 'In case of a landslide, roads may be blocked, power may be cut off, and essential services may be delayed.\n\nWhat to Include?\n- Water: At least three days’ supply for each person.\n- Food: Non-perishable items like canned food, energy bars, and dry fruits.\n- Flashlight & Batteries: For visibility in case of power outages.\n- First Aid Kit: Bandages, antiseptics, necessary medications.\n- Important Documents: IDs, insurance papers, emergency contacts, and maps.\n- Clothing & Blanket: To stay warm and dry.',
            ),
            AnimatedTile(
              title: 'Step 3: Plan Evacuation',
              description: 'Knowing escape routes and safe zones can save lives during an emergency.\n\nHow?\n- Identify and mark safe areas (higher ground away from slopes).\n- Plan multiple escape routes in case roads are blocked.\n- Discuss the evacuation plan with family or community members.\n- Keep emergency contacts ready and inform loved ones about your plans.',
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedTile extends StatelessWidget {
  final String title;
  final String description;

  const AnimatedTile({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        backgroundColor: Colors.teal.shade50,
        collapsedBackgroundColor: Colors.white,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 134, 202, 241),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(255, 89, 191, 250),
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



class ResourceRequestsPage extends StatelessWidget {
  final TextEditingController _requestController = TextEditingController();

  final String recipientPhoneNumber = '+916235887925'; // Recipient phone number with country code

  void _sendWhatsAppMessage(BuildContext context, String requestDetails) async {
    final url = Uri.parse('https://wa.me/$recipientPhoneNumber?text=${Uri.encodeComponent(requestDetails)}');

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: Text('Resource Requests'),
          centerTitle: true,
          backgroundColor: Colors.teal,
          elevation: 10,
          shadowColor: Colors.tealAccent,
        ).animate().fadeIn(duration: 1.seconds).slideY(), // Animation applied
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
            ).animate().fadeIn(duration: 1.seconds).slideX(),
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
            ).animate().fadeIn(duration: 1.seconds).slideY(delay: 300.ms),
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
                    Text(
                      'Send via WhatsApp',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 1.seconds).scale(),
            ),
            SizedBox(height: 30),
            Image.asset(
              'assets/images/whatsapp_banner.png', // Add a creative image here
              height: 200,
            ).animate().fadeIn(duration: 1.5.seconds).slideY(delay: 500.ms),
          ],
        ).animate().fadeIn(duration: 1.seconds),
      ),
    );
  }
}
