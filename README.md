# JediTravels — Hotel Booking App

A full-stack cross-platform hotel booking mobile application built with Flutter and Firebase. Users can browse hotels, make bookings, and complete secure payments — all from a single app that runs on both Android and iOS.

---

## Screenshots

> Add 4 screenshots here after taking them from the emulator.  
> Example: `![Home Screen](screenshots/home.png)`

---

## Features

- **Onboarding** — animated 3-screen introduction with page indicators
- **Authentication** — email/password login, registration, and password reset via Firebase Auth
- **Hotel Discovery** — browse Recommended and Popular hotels with images, ratings, locations, and pricing
- **Hotel Details** — full detail page with amenities (Sports, Parking, Bar, WiFi), star ratings, and descriptions
- **Booking & Payments** — check-in/check-out date and time selection with secure payment processing via Razorpay
- **User Profile** — profile page fetching real-time data from Cloud Firestore
- **Offers** — promotional banners and discount codes
- **Settings** — notification toggles, About page, Terms and Conditions
- **Cross-platform** — single Dart codebase runs on both Android and iOS

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter 3.x (Dart) |
| Authentication | Firebase Auth 5.x |
| Database | Cloud Firestore 5.x |
| Payments | Razorpay Flutter SDK |
| Fonts | Google Fonts |
| Vector Graphics | Flutter SVG |
| State Management | StatefulWidget / setState |
| Navigation | Named routes with MaterialPageRoute |

---

## Architecture
```
lib/
├── main.dart                  # App entry point, Firebase init, route definitions
├── constants.dart             # Global colours and padding constants
├── screens/
│   └── home/
│       ├── home_screen.dart   # Bottom navigation shell (4 tabs)
│       └── components/
│           ├── header_with_search.dart
│           ├── recomend_hotels.dart
│           ├── popular.dart
│           └── show_all.dart
├── login.dart                 # Firebase email/password sign-in
├── registration.dart          # Firebase user creation + Firestore profile
├── ResetPassword.dart         # Firebase password reset email
├── onboarding.dart            # 3-page swipeable intro
├── start.dart                 # Welcome screen with Login/Register
├── dashboard.dart             # Home tab — hotel listings
├── hotel_details.dart         # Hotel detail page
├── payments.dart              # Razorpay payment gateway integration
├── profile.dart               # User profile from Firestore
├── offers.dart                # Promotional offers
├── settings.dart              # App settings
├── about.dart                 # About page
└── terms_conditions.dart      # Terms and Conditions
```

---

## Setup & Installation

### Prerequisites
- Flutter 3.x SDK
- Android Studio with Android SDK 36
- Firebase project with Android app configured
- Razorpay account (test mode)

### Steps
```bash
# Clone the repository
git clone https://github.com/Viswanadareddy/JediTravels.git
cd JediTravels

# Install dependencies
flutter pub get

# Run on Android emulator or device
flutter run
```

> **Note:** This project requires a `google-services.json` file in `android/app/` from your own Firebase project. This file is excluded from the repository for security. See [Firebase setup guide](https://firebase.google.com/docs/android/setup) to configure your own.

---

## Firebase Configuration

1. Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
2. Add an Android app with package name `com.example.loginout`
3. Download `google-services.json` and place it in `android/app/`
4. Enable **Authentication** (Email/Password)
5. Enable **Cloud Firestore** in test mode
6. Set Firestore security rules to require authentication:
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

---

## Key Technical Decisions

**Why Flutter?**  
A single Dart codebase compiles to both Android and iOS, reducing development time significantly compared to maintaining two separate native codebases.

**Why Firebase?**  
Firebase handles authentication, real-time database, and cloud storage without requiring a custom backend server — the right tradeoff for this project's scope.

**Why Razorpay?**  
Razorpay handles PCI-compliant payment processing. The app never touches raw card data — all sensitive payment information is handled entirely within Razorpay's SDK.

---

## What I Learned

- Integrating third-party payment APIs (Razorpay) with Flutter
- Real-time NoSQL database design and querying with Cloud Firestore
- Firebase Authentication flows including email/password and password reset
- Flutter widget architecture — StatefulWidget vs StatelessWidget, widget composition
- Cross-platform mobile development from a single codebase
- Migrating a Flutter project from 2021 dependencies to Flutter 3.x / AGP 8.6 / Gradle 8.10

---

## Future Improvements

- Migrate state management from StatefulWidget to Riverpod
- Add AI hotel concierge using Google Gemini API
- Implement real hotel data from Firestore instead of hardcoded lists
- Add search functionality
- Implement booking history for users
- Write unit and widget tests
- Deploy to Google Play Store

---

## License

This project is for portfolio and educational purposes.

---

*Built with Flutter and Firebase*
```

After saving, run these three commands to push the updated README to GitHub:
```
git add README.md
git commit -m "docs: add comprehensive project README"
git push
