# Weather Forecasting App

## Overview
This is a cross-platform mobile application built using Flutter that provides weather forecasts for cities. It features:
- Current weather information (temperature, humidity, weather description).
- A 3-day weather forecast.
- Ability to switch between Celsius and Fahrenheit.
- Persistent storage for last searched city and unit preferences.

---

## Prerequisites
- **Flutter SDK**: Ensure Flutter is installed. Follow the [Flutter installation guide](https://docs.flutter.dev/get-started/install) for your platform.
- **API Key**: Sign up at [OpenWeather API](https://openweathermap.org/api) and get your free API key.
- **Dependencies**: Install the required packages listed in the `pubspec.yaml` file.

---

## Setup Instructions

### Step 1: Clone the Repository
Clone this repository to your local machine using:
```bash
git clone https://github.com/adnankhanmgdp/weather_forecast_app/
```

### Step 2: Navigate to the Project Directory
```bash
cd weather_forecast_app
```

### Step 3: Install Dependencies
Run the following command to fetch all the required dependencies:
```bash
flutter pub get
```

### Step 4: Configure API Key
- Open the file `lib/utility/app_constants.dart`.
- Replace `YOUR_API_KEY` with your OpenWeather API key:
  ```dart
  static const String weatherApiKey = "API-KEY"
  ```

### Step 5: Run the App
To run the app on an emulator or a physical device, use:
```bash
flutter run
```

---

## APK Installation
To install the APK on an Android device:
1. Download the `weather-app.apk` file from the `build/apk` folder.
2. Transfer it to your Android device.
3. Install the APK.

---

## Features
- **Search Bar**: Find weather details for any city.
- **Current Weather**: Displays temperature, humidity, and weather description.
- **Forecast**: View a 3-day weather forecast.
- **Unit Toggle**: Switch between Celsius and Fahrenheit.
- **Persistent Data**: Remembers last searched city and unit preference.

---

## Troubleshooting
1. **API Key Errors**:
   - Ensure the API key is correctly added and valid.
   - Check the API usage limit in your OpenWeather account.

2. **Dependency Issues**:
   - Run `flutter pub get` to resolve missing dependencies.

3. **Platform-Specific Errors**:
   - For iOS, ensure you have CocoaPods installed and run:
     ```bash
     pod install
     ```
   - For Android, ensure the Android SDK is correctly configured.

---

## Contributing
Contributions are welcome! To contribute:
1. Fork the repository.
2. Create a feature branch.
3. Submit a pull request.

---

## License
This project is licensed under the MIT License. See the `LICENSE` file for details.
