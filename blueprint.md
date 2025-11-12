# CartPal Shopping List App

## Overview

CartPal is a mobile application designed to simplify your grocery shopping experience. It allows you to create, manage, and organize multiple shopping lists with ease. The standout feature is the automatic categorization of items, which groups similar products together, making your trip to the store more efficient.

## Features & Design

### Core Functionality
- **Multiple Shopping Lists:** Create and manage as many shopping lists as you need.
- **Item Management:** Add, delete, and mark items as complete within each list.
- **Automatic Categorization:** Items are automatically sorted into categories like "Fruits," "Dairy," "Pantry," etc., as you add them.
- **Grouped Item View:** Items within a list are displayed in collapsible sections based on their category, making it easy to navigate long lists.
- **Total Cost Calculation:** Track the price of each item and view the total cost of all purchased (checked) items in a list.
- **Crash Reporting:** Automatically reports crashes to Firebase Crashlytics for easier debugging.
- **Analytics:** Tracks user engagement and app usage with Firebase Analytics.

### Style & Design
- **Theme:** The app uses Material 3 design principles with a modern and clean aesthetic.
- **Color Scheme:** A flexible color scheme is generated from a primary seed color (`Colors.blue`), ensuring a harmonious look.
- **Typography:** The app uses the "Lato" font from Google Fonts for a clean and readable text hierarchy.
- **Dark/Light Mode:** Includes a theme toggle to switch between light and dark modes, respecting the system theme by default.
- **Navigation:** Uses the `go_router` package for a declarative and robust navigation system.
- **State Management:** Emplains the `provider` package for efficient and centralized state management.

## Current Plan: Integrate Firebase Crashlytics and Analytics

The goal of this change was to integrate Firebase Crashlytics and Analytics to improve error reporting and user insights.

### Steps Completed:
1.  **Add Dependencies:** Added `firebase_crashlytics` and `firebase_analytics` to the `pubspec.yaml` file.
2.  **Initialize Firebase:** Uncommented Firebase initialization in `lib/main.dart`.
3.  **Configure Crashlytics:** Set up the `FlutterError.onError` handler to record Flutter errors with `FirebaseCrashlytics`.
4.  **Enable Analytics:** Added the `FirebaseAnalyticsObserver` to the `GoRouter` to automatically track screen views.
