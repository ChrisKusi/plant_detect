# Plant Disease Detection App

The **Plant Disease Detection App** is a mobile application developed using Flutter that utilizes machine learning to detect plant diseases from images captured by the user. The app integrates with a backend service to process the images and provides users with actionable solutions and best practices for the detected plant diseases. This project aims to assist farmers and gardeners in identifying and managing plant diseases efficiently.

## Table of Contents

- [Features](#features)
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Features

- **Image Capture:** Capture images using the device's camera or select from the gallery.
- **Disease Detection:** Sends images to the backend for disease detection using a machine learning model.
- **Location Tagging:** Automatically tags images with the user's geographical location.
- **Solutions & Best Practices:** Provides tailored solutions and best practices for each detected disease.
- **User-Friendly Interface:** Simple and intuitive interface designed for easy navigation and use.

## Technologies Used

- **Flutter** - Frontend framework for building the mobile application.
- **Flask** - Backend framework used to handle image processing and disease detection.
- **YOLOv8 Model** - Machine learning model used for object detection and disease recognition.
- **OpenCV** - Library used for image processing in the backend.
- **Location** - Location services used to tag the captured images with GPS coordinates.
- **EXIF** - Metadata handling for images.
- **HTTP** - Used for API communication between the app and backend.

## Installation

### Prerequisites

Ensure you have the following installed on your system:

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Python 3.x: [Install Python](https://www.python.org/downloads/)
- Flask and required dependencies: Install using the requirements file.

```bash
# Clone the repository
git clone https://github.com/ChrisKusi/plant_detect.git

# Navigate into the project directory
cd plant_detect

# Install Flutter dependencies
flutter pub get

# Start the Emulator or run it on your physical device
flutter run

# Build the apk using:
flutter build apk --release


# To connect the backend with the app:

# 1. Clone the repository
    - git clone https://github.com/ChrisKusi/plant_disease_backend.git

# 2. Navigate into the backend directory and install Python dependencies
    - cd backend-app-detect
    - pip install -r requirements.txt

# 3. Run the Flask server
    - flask run --host=0.0.0.0

```

## Usage
- Open the app on your device.
- Use the Take Photo button to capture an image or Pick Gallery to select an image from your device.
- The app will automatically tag the image with your current location.
- Click Detect Disease to send the image to the backend for processing.
- View the results, which include the detected disease, confidence level, suggested solutions, and best practices.
- In the notify tab, input the details of the email recipient.

## Contributing
    We welcome contributions to improve this project. If you would like to contribute, please follow these steps:

    1. Fork the repository.
    2. Create a new branch (git checkout -b feature/your-feature-name).
    3. Make your changes.
    4. Commit your changes (git commit -m 'Add some feature').
    5. Push to the branch (git push origin feature/your-feature-name).
    6. Open a Pull Request.


## License
    This project is licensed under the MIT License. See the LICENSE file for details.

## Contact
- Project Maintainer: Christian Kusi
- Email: your-email@example.com
- GitHub: ChrisKusi

Feel free to customize this `README.md` further based on specific details of your project. If you need additional sections or modifications, let me know!