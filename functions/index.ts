import * as functions from "firebase-functions";
import * as express from "express";
import * as cors from "cors";

const { spawn } = require("child_process");

const app = express();
app.use(cors({ origin: true }));

// API endpoint for landslide prediction
app.post("/predict", (req, res) => {
    const pythonProcess = spawn("python3", ["main.py", JSON.stringify(req.body)]);

    pythonProcess.stdout.on("data", (data: Buffer) => {
        res.json(JSON.parse(data.toString()));
    });

    pythonProcess.stderr.on("data", (data: Buffer) => {
        res.status(500).json({ error: data.toString() });
    });
});

// Root endpoint
app.get("/", (req, res) => {
    res.send("Landslide Prediction API running on Firebase!");
});

// Export the API as a Firebase function
export const api = functions.https.onRequest(app);
