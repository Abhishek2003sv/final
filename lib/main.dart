// Main entry point for the Flutter application
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/firebase_services.dart';
import 'package:my_flutter_app/prediction_page.dart';
import 'weather_service.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// void main() {
//   runApp(LandslideApp());
  
//   Container(
//   color: Colors.cyan, // Sets the background color
//   padding: const EdgeInsets.all(16.0),
//    // Adds padding inside the container
// );
///}
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(LandslideApp());
// }



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


// void main() async {
//   Container(
//   color: Colors.cyan, // Sets the background color
//   padding: const EdgeInsets.all(16.0), // Adds padding inside the container
//   );
//   WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter is ready to initialize Firebase
//   await Firebase.initializeApp(); // Initializes Firebase
//   runApp(LandslideApp());
// }

class LandslideApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Landslide Prediction App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;

@override
void initState() {
  super.initState();
  _controller = VideoPlayerController.asset('assets/0_Earth_Planet_3840x2160.mp4')
    ..initialize().then((_) {
      setState(() {
        _controller
          ..play()
          ..setLooping(true)
          ..setVolume(0.0);
        print("Video initialized successfully!");
      });
    }).catchError((error) {
      print("Error initializing video: $error");
    });
}


@override
Future<void> dispose() async {
    _controller.dispose();
    super.dispose();
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        // Video background
        if (_controller.value.isInitialized)
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          )
        else
          Center(
            child: CircularProgressIndicator(), // Loading indicator
          ),

        // Dark overlay
        Container(
          // ignore: deprecated_member_use
          color: const Color.fromARGB(255, 39, 176, 255).withOpacity(0.5), // Adjust opacity for better visibility
        ),

        // Overlay content
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 60),
              Center(
                child: Text(
                  'Welcome to the Landslide Prediction App',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 34,
                        color: Colors.white, // Visible on dark overlay
                      ),
                ),
              ),
              SizedBox(height: 40),
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
}

Widget _buildButton(BuildContext context, String label, IconData icon, VoidCallback onPressed) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        iconColor: const Color.fromARGB(255, 16, 131, 189),
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        padding: EdgeInsets.all(20),
        textStyle: TextStyle(fontSize: 20),
        shadowColor: Color.fromARGB(100, 163, 32, 9),
      ),
    ),
  );
}


class PredictionPage extends StatelessWidget {
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
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Location',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle prediction logic
              },
              child: Text('Predict'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Prediction Results will appear here.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ],
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
        title: Text('Guidance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ExpansionTile(
              title: Text('Step 1: Stay Informed'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Monitor weather reports and warnings from authorities.',
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Step 2: Prepare Emergency Kit'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Include essentials such as water, food, flashlight, and medicines.',
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text('Step 3: Plan Evacuation'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Identify safe areas and routes in advance.',
                  ),
                ),
              ],
            ),
          ],
        ),
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
        backgroundColor: Colors.lightBlue,  // You can set your primary blue color here.
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

class ResourceRequestsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resource Requests'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Request Resources',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Your Need',
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle resource request submission
              },
              child: Text('Submit Request'),
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
// FeedbackPage class (Move it outside of HomePage)
}



class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}
class _FeedbackPageState extends State<FeedbackPage> {
  final FirebaseServices firebaseServices = FirebaseServices();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Feedbacks'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Your Name')),
            SizedBox(height: 8),
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Your Email')),
            SizedBox(height: 8),
            TextField(controller: feedbackController, decoration: InputDecoration(labelText: 'Your Feedback'), maxLines: 3),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final email = emailController.text.trim();
                final feedback = feedbackController.text.trim();

                if (name.isEmpty || email.isEmpty || feedback.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill out all fields.')));
                } else {
                  await firebaseServices.addFeedback(name, email, feedback);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Thank you for your feedback!')));
                  nameController.clear();
                  emailController.clear();
                  feedbackController.clear();
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
