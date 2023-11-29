import torch
import cv2

# Model
model = torch.hub.load(".", "custom", "../models/syndoc_vhs.pt", source="local")

# Images
img = "test.jpg"  # URL, Path, PIL, OpenCV, numpy, list

# Inference
results = model(img)

# Results
results.show()  # or .print(), .save(), .crop(), .pandas(), etc.

# Save image
output_path = "preview.jpg"
cv2.imwrite(output_path, cv2.cvtColor(results.render()[0], cv2.COLOR_RGB2BGR))  # Convert back to BGR before saving
