# SmartMed 🏥

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![MongoDB](https://img.shields.io/badge/MongoDB-4EA94B?style=for-the-badge&logo=mongodb&logoColor=white)](https://www.mongodb.com)

SmartMed is a comprehensive Flutter-based medical application designed to bridge the gap between healthcare providers and patients. The app offers a secure, intuitive platform for managing medical appointments, prescriptions, and health records with role-based access control.

## 🌟 Key Features

### For Doctors 👨‍⚕️
- **Appointment Management**: View, schedule, and manage patient appointments
- **Prescription Creation**: Digital prescription writing with medication database
- **Patient Records**: Access comprehensive patient medical histories
- **Dashboard Analytics**: Overview of daily appointments and patient statistics

### For Patients 👤
- **Easy Appointment Booking**: Schedule appointments with preferred doctors
- **Medical Records Access**: View personal health records and test results
- **Prescription Tracking**: Monitor current and past prescriptions
- **Health Timeline**: Track medical visits and treatments over time

### Security & Authentication 🔒
- Role-based authentication system
- Secure data encryption
- HIPAA-compliant data handling
- Session management with automatic logout

## 🛠️ Technology Stack

| Technology | Purpose | Version |
|------------|---------|---------|
| Flutter | Cross-platform mobile development | Latest stable |
| Dart | Programming language | ^3.8.1 |
| Provider | State management | Latest |
| MongoDB | Database (via mongo_dart) | Latest |
| Material Design | UI/UX framework | Built-in |
| Cupertino Icons | iOS-style icons | Latest |

## 📱 Screenshots

<table>
  <tr>
    <td align="center">
      <img src="screenshots/Login screen.png" width="200px" alt="Login Screen"/>
      <br />
      <sub><b>Login Screen</b></sub>
    </td>
    <td align="center">
      <img src="screenshots/role selection.png" width="200px" alt="Role Selection"/>
      <br />
      <sub><b>Role Selection</b></sub>
    </td>
    <td align="center">
      <img src="screenshots/Doctor dashboard.png" width="200px" alt="Doctor Dashboard"/>
      <br />
      <sub><b>Doctor Dashboard</b></sub>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="screenshots/patient dashboard.png" width="200px" alt="Patient Dashboard"/>
      <br />
      <sub><b>Patient Dashboard</b></sub>
    </td>
    <td align="center">
      <img src="screenshots/Patient appointment screen.png" width="200px" alt="Appointments"/>
      <br />
      <sub><b>Appointment Management</b></sub>
    </td>
    <td align="center">
      <img src="screenshots/medical records.png" width="200px" alt="Medical Records"/>
      <br />
      <sub><b>Medical Records</b></sub>
    </td>
  </tr>
</table>

## 🚀 Getting Started

### Prerequisites

Before running this application, ensure you have the following installed:

- **Flutter SDK** (>=3.0.0) - [Installation Guide](https://docs.flutter.dev/get-started/install)
- **Dart SDK** (^3.8.1) - Comes with Flutter
- **Android Studio** or **Xcode** for mobile development
- **MongoDB** instance (local or cloud)
- **Git** for version control

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/smartmed.git
   cd smartmed
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure database connection**
   ```bash
   # Create a config file or update connection strings
   cp lib/config/database_config.example.dart lib/config/database_config.dart
   ```

4. **Run the application**
   ```bash
   # For debug mode
   flutter run

   # For specific platform
   flutter run -d android
   flutter run -d ios
   ```

5. **Build for production**
   ```bash
   # Android APK
   flutter build apk --release

   # iOS IPA
   flutter build ipa --release
   ```

## 📁 Project Architecture

```
lib/
├── app.dart             # Application setup file
├── main.dart            # Application entry point
├── mongodb_options.dart # MongoDB configuration options
├── models/              # Data models
│   ├── app_user.dart
│   └── other model files...
├── providers/           # State management
│   ├── auth_provider.dart
│   └── other provider files...
├── screens/             # UI screens
│   ├── auth/
│   ├── doctor/
│   ├── patient/
│   └── shared/
├── services/            # Business logic & API calls
│   ├── mongodb_service.dart
│   └── other service files...
|___ widgets/             # Reusable UI components
    ├── custom_button.dart
    └── other widget files...
```

## 🔧 Configuration

### Database Setup

1. **MongoDB Connection**
   ```dart
   // lib/config/database_config.dart
   class DatabaseConfig {
     static const String connectionString = 'mongodb://localhost:27017/smartmed';
     static const String databaseName = 'smartmed';
   }
   ```

2. **Environment Variables**
   Create a `.env` file in the root directory:
   ```env
   MONGODB_URI=your_mongodb_connection_string
   JWT_SECRET=your_jwt_secret_key
   API_BASE_URL=your_api_base_url
   ```

## 🧪 Testing

Run the following commands to execute tests:

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run integration tests
flutter drive --target=test_driver/app.dart
```

## 📦 Dependencies

### Core Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.5
  mongo_dart: ^0.8.2
  cupertino_icons: ^1.0.2
  http: ^0.13.5
  shared_preferences: ^2.0.18
  image_picker: ^0.8.7
  
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
  mockito: ^5.3.2
```

## 🤝 Contributing

We welcome contributions to SmartMed! Please follow these steps:

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Commit your changes**
   ```bash
   git commit -m 'Add some amazing feature'
   ```
4. **Push to the branch**
   ```bash
   git push origin feature/amazing-feature
   ```
5. **Open a Pull Request**

### Code Style Guidelines
- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Add comments for complex logic
- Write tests for new features

## 🐛 Issue Reporting

If you encounter any bugs or have feature requests, please:

1. Check if the issue already exists
2. Create a new issue with detailed description
3. Include steps to reproduce (for bugs)
4. Add relevant screenshots or logs

## 📋 Roadmap

- [ ] **Phase 1**: Core functionality (✅ Completed)
- [ ] **Phase 2**: Advanced features
    - [ ] Video consultation integration
    - [ ] AI-powered symptom checker
    - [ ] Medication reminders
    - [ ] Lab report integration
- [ ] **Phase 3**: Analytics & Insights
    - [ ] Health analytics dashboard
    - [ ] Predictive health insights
    - [ ] Population health management

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2024 SmartMed Team

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
```

## 👥 Authors & Acknowledgments

- **Development Team** - Initial work and ongoing maintenance
- **Healthcare Professionals** - Domain expertise and requirements
- **Beta Testers** - Valuable feedback and bug reports

## 📞 Support

For support and questions:

- 📧 Email: support@smartmed.app
- 💬 Discord: [SmartMed Community](https://discord.gg/smartmed)
- 🎫 Issues: [GitHub Issues](https://github.com/varshini2304/smartmed/issues)

---

<div align="center">

**Built with ❤️ for better healthcare**

[Website](https://smartmed.app) • [Documentation](https://docs.smartmed.app) • [Community](https://discord.gg/smartmed)

</div>