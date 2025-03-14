import sys
import pickle
import numpy as np

model_path = sys.argv[1]
temperature = float(sys.argv[2])
humidity = float(sys.argv[3])
rainfall = float(sys.argv[4])

model = pickle.load(open(model_path, "rb"))
input_data = np.array([[temperature, humidity, rainfall]])
prediction = model.predict(input_data)

print(int(prediction[0]))  # 1 = Landslide, 0 = No Landslide
