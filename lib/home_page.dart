import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'login_page.dart';  // Import your login page
import 'main.dart';
import 'prediction_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> newsList = [
    "Stay alert during heavy rains.",
    "Check landslide-prone areas before travel.",
    "Emergency helpline: 112.",
    "Use safe routes during bad weather",
  ];

  bool _isDarkMode = false; 
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user; 

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser; 
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        backgroundColor: _isDarkMode ? Colors.black87 : Colors.lightGreen[100],
        appBar: AppBar(
          title: Text("Landslide Prediction App"),
          backgroundColor: Colors.green[800],
          actions: [
            AnimatedScale(
              scale: 1.2, 
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: IconButton(
                icon: Icon(Icons.account_circle, size: 30),
                onPressed: () => _showUserDetails(context),
              ),
            ),

            if (user != null)
              AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(milliseconds: 500),
                child: IconButton(
                  icon: Icon(Icons.logout, color: Colors.white),
                  onPressed: () async {
                    await _auth.signOut();
                    setState(() {
                      user = null;
                    });
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()), // Redirect to Login
                    );
                  },
                ),
              ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),

            SwitchListTile(
              title: Text(
                "Dark Mode",
                style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
              ),
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
              },
              secondary: Icon(
                _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: _isDarkMode ? Colors.white : Colors.black,
              ),
            ),

            Container(
              color: Colors.green,
              height: 40,
              child: Marquee(
                text: newsList.join("  •  "),
                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                scrollAxis: Axis.horizontal,
                blankSpace: 50.0,
                velocity: 50.0,
                pauseAfterRound: Duration(seconds: 1),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [
                    _buildHoverButton(context, 'Landslide Prediction', Icons.warning, PredictionPage()),
                    _buildHoverButton(context, 'Guidance', Icons.help, GuidancePage()),
                    _buildHoverButton(context, 'Weather Forecasting', Icons.cloud, WeatherForecastingPage()),
                    _buildHoverButton(context, 'Emergency Alerts', Icons.notifications, EmergencyAlertsPage()),
                    _buildHoverButton(context, 'Resource Requests', Icons.support, ResourceRequestsPage()),
                    _buildHoverButton(context, 'Contact Us', Icons.feedback, FeedbackPage()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showUserDetails(BuildContext context) {
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Not Logged In")));
      return;
    }

    showDialog(
      context: context,
      builder: (context) => FadeTransition(
        opacity: AlwaysStoppedAnimation(0.8),
        child: AlertDialog(
          title: Text("User Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: user!.photoURL != null
                    ? NetworkImage(user!.photoURL!)
                    : AssetImage("assets/default_user.png") as ImageProvider, 
              ),
              SizedBox(height: 10),
              Text("Name: ${user!.displayName ?? "N/A"}"),
              Text("Email: ${user!.email}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHoverButton(BuildContext context, String label, IconData icon, Widget page) {
    return MouseRegion(
      onEnter: (event) => setState(() {}),
      onExit: (event) => setState(() {}),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => page));
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: _isDarkMode ? Colors.grey[900] : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(2, 2),
              ),
            ],
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 1.0, end: 1.1),
                duration: Duration(milliseconds: 300),
                builder: (context, double scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: Icon(
                      icon,
                      size: 40,
                      color: _isDarkMode ? Colors.white : Colors.green[700],
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: _isDarkMode ? Colors.white : Colors.green[900],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
