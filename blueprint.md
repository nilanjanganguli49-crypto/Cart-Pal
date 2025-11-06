# CartPal Shopping List App

## Overview

CartPal is a mobile application designed to simplify your grocery shopping experience. It allows you to create, manage, and organize multiple shopping lists with ease. The standout feature is the automatic categorization of items, which groups similar products together, making your trip to the store more efficient.

## Features & Design

### Core Functionality
- **Multiple Shopping Lists:** Create and manage as many shopping lists as you need.
- **Item Management:** Add, delete, and mark items as complete within each list.
- **Automatic Categorization:** Items are automatically sorted into categories like "Fruits," "Dairy," "Pantry," etc., as you add them.
- **Grouped Item View:** Items within a list are displayed in collapsible sections based on their category, making it easy to navigate long lists.

### Style & Design
- **Theme:** The app uses Material 3 design principles with a modern and clean aesthetic.
- **Color Scheme:** A flexible color scheme is generated from a primary seed color (`Colors.blue`), ensuring a harmonious look.
- **Typography:** The app uses the "Lato" font from Google Fonts for a clean and readable text hierarchy.
- **Dark/Light Mode:** Includes a theme toggle to switch between light and dark modes, respecting the system theme by default.
- **Navigation:** Uses the `go_router` package for a declarative and robust navigation system.
- **State Management:** Employs the `provider` package for efficient and centralized state management.

## Current Plan

The project is now complete. All core features have been implemented as per the initial plan.

### Implemented Steps:
1.  **Project Setup:** Initialized a Flutter project with necessary dependencies (`google_fonts`, `provider`, `go_router`).
2.  **Theming:** Implemented a theming system with light/dark mode support.
3.  **Data Models:** Created `ShoppingList` and `ShoppingItem` data models.
4.  **State Management:** Built a `ListProvider` to manage the application's state.
5.  **UI - List Management:** Developed the `ShoppingListsScreen` to create, view, and delete lists.
6.  **UI - Item Management:** Developed the `ShoppingListScreen` to add, delete, and check off items.
7.  **Categorization Service:** Implemented `CategorizationService` with a keyword-based approach to automatically categorize items.
8.  **UI - Grouped View:** Updated the `ShoppingListScreen` to display items grouped by their categories in expandable tiles.