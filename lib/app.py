from fastapi import FastAPI
import joblib
import numpy as np

# Initialize FastAPI app
app = FastAPI()

# Load trained landslide prediction model
model = joblib.load("landslide_prediction_model.pkl")

@app.get("/")
def home():
    return {"message": "Landslide Prediction API is Running!"}

@app.post("/predict/")
def predict(temperature: float, humidity: float, rainfall: float):
    """
    Predict landslide risk based on temperature, humidity, and rainfall.
    """
    input_data = np.array([[temperature, humidity, rainfall]])
    prediction = model.predict(input_data)
    return {"landslide_risk": int(prediction[0])}
