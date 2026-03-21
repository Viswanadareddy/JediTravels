# JediTravels — Hotel Booking Mobile App
A full-stack cross-platform mobile application built with Flutter and Firebase.
Users can browse hotels, make bookings, and complete payments — all from
a single app that runs on both Android and iOS.

## Features
- **Authentication** — Email/password login, Google Sign-In, password reset (Firebase Auth)
- **Hotel Discovery** — Browse hotels with images, pricing, ratings, and amenities
- **Real-time Booking** — Select check-in/check-out dates and book rooms instantly
- **Payment Integration** — Secure payments via Razorpay payment gateway
- **User Profiles** — Editable profile with photo upload
- **Offers & Promotions** — Dynamic promotional banners with discount codes

## Tech Stack
| Layer | Technology |
|-------|-----------|
| Frontend | Flutter (Dart) |
| Authentication | Firebase Auth |
| Database | Cloud Firestore (NoSQL) |
| Payments | Razorpay API |
| State Management | StatefulWidget |
| Navigation | MaterialPageRoute |

## Architecture
Multi-screen app with route-based navigation. Firebase handles all
backend operations — no custom server required. Razorpay handles
PCI-compliant payment processing.

## Screenshots
[Add 3-4 screenshots from your appendix here]

## What I Learned
- Integrating third-party payment APIs (Razorpay)
- Real-time NoSQL database design with Firestore
- Cross-platform mobile development with a single codebase
- Firebase Authentication flows including Google OAuth
- Flutter widget architecture and state management

## Setup
```bash
git clone https://github.com/Viswanadareddy/JediTravels-main
cd JediTravels-main
flutter pub get
flutter run
```
*Note: Requires Firebase config file (not included for security)*
