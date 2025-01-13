from flask import Flask, request, jsonify
from flask_cors import CORS
import requests
import numpy as np

app = Flask(__name__)
CORS(app)

# OpenWeatherMap API Key
OPENWEATHER_API_KEY = "your_api_key"

# Function to fetch real-time weather data
def fetch_weather(city):
    url = f"https://api.openweathermap.org/data/2.5/weather?q={city}&appid={OPENWEATHER_API_KEY}&units=metric"
    response = requests.get(url)
    if response.status_code == 200:
        return response.json()
    else:
        raise Exception("Failed to fetch weather data")

# Simple landslide risk calculation based on rainfall
def calculate_landslide_risk(rainfall_mm):
    if rainfall_mm > 100:
        return "High"
    elif rainfall_mm > 50:
        return "Moderate"
    else:
        return "Low"

@app.route("/predict", methods=["GET"])
def predict():
    city = request.args.get("city")
    if not city:
        return jsonify({"error": "City is required"}), 400

    try:
        weather_data = fetch_weather(city)
        rainfall_mm = weather_data.get("rain", {}).get("1h", 0)  # Rainfall in the last hour (mm)
        risk = calculate_landslide_risk(rainfall_mm)
        
        return jsonify({
            "city": city,
            "temperature": weather_data["main"]["temp"],
            "rainfall": rainfall_mm,
            "landslide_risk": risk
        })
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(debug=True)
