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

### Style & Design
- **Theme:** The app uses Material 3 design principles with a modern and clean aesthetic.
- **Color Scheme:** A flexible color scheme is generated from a primary seed color (`Colors.blue`), ensuring a harmonious look.
- **Typography:** The app uses the "Lato" font from Google Fonts for a clean and readable text hierarchy.
- **Dark/Light Mode:** Includes a theme toggle to switch between light and dark modes, respecting the system theme by default.
- **Navigation:** Uses the `go_router` package for a declarative and robust navigation system.
- **State Management:** Employs the `provider` package for efficient and centralized state management.

## Current Plan: Implement Total Cost Feature

The next step is to add a feature to track the cost of each item and display the total cost for each shopping list.

### Steps:
1.  **Update Data Model:** Add a `price` property (double) to the `ShoppingItem` class in `lib/models.dart`.
2.  **Update State Management:**
    *   Add a method to `ListProvider` in `lib/list_provider.dart` to update the price of a `ShoppingItem`.
    *   Add a getter to `ListProvider` to calculate the total cost of all checked items in a `ShoppingList`.
3.  **Update UI (`ShoppingListScreen`):**
    *   In `lib/screens/shopping_list_screen.dart`, add a `TextField` to each list item to allow users to input the price. This field should only be visible when the item is checked.
    *   Display the total cost at the bottom of the shopping list screen.
    *   Ensure the UI updates automatically when item prices are entered or when items are checked/unchecked.
