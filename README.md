## Assignment Answers

### 1. Explain what are stateless widgets and stateful widgets, and explain the difference between them.

**Answer:**

In Flutter, widgets are like the building blocks of the app's user interface.

- **Stateless widgets** are like pictures—they display static content that doesn't change over time. They are used for parts of the app that don't need to update dynamically.

- **Stateful widgets** are like interactive gadgets—they can change and update in response to user actions or data changes. They are used when the app needs to react to changes.

The key difference is that stateless widgets remain the same once built, while stateful widgets can rebuild themselves when their state changes.

### 2. Mention the widgets that you have used for this project and their uses.

**Answer:**

- **MaterialApp**: Sets up the app's basic configurations, including the theme and home screen.
- **Scaffold**: Provides a structure for the app, including app bar and body.
- **AppBar**: Displays the app bar at the top with the shop's name.
- **Text**: Displays text on the screen.
- **GridView**: Creates a grid layout to display the buttons.
- **Material**: Applies Material Design styling to widgets.
- **InkWell**: Makes widgets respond to touch (used to create tappable buttons).
- **Icon**: Displays an icon from the Material Icons library.
- **SnackBar**: Shows brief messages at the bottom of the screen in response to user actions.

### 3. What is the use-case for setState()? Explain the variable that can be affected by setState().

**Answer:**

**setState()** is used in stateful widgets to inform the app that some data has changed and the UI needs to update to reflect this change. It's like telling the app to refresh a part of the screen.

Variables that can be affected by **setState()** are those that are part of the widget's state and can change over time, such as counters, form inputs, or any dynamic data.

(Note: In this project, we used stateless widgets, so **setState()** was not utilized.)

### 4. Explain the difference between const and final keyword.

**Answer:**

- **const**: Indicates that a value is constant and unchangeable. It must be known at compile time. It's like setting something in stone—it cannot be altered.

- **final**: Means that a variable can be set once and cannot be changed afterward. The value can be determined at runtime. It's like filling a jar—you can put something in it once, and then it's sealed.

Both are used to create variables that shouldn't change, but **const** is more restrictive and requires the value to be known ahead of time.

### 5. Explain how you implemented the checklist above step-by-step.

**Answer:**

1. **Created a new Flutter application named `bonbon_shop`.**

2. **Modified `main.dart`** to change the app title to "Bonbon's Shop" and adjusted the theme colors to shades of orange to match the shop's theme.

3. **Created `menu.dart`** in the `lib` directory to organize the main menu code separately from `main.dart`.

4. **Moved `MyHomePage` from `main.dart` to `menu.dart`**, adjusting it to display the shop name and a welcome message.

5. **Created a list of buttons**—View Product List, Add Product, and Logout—each with its own icon and assigned different colors to each to match the orange theme.

6. **Created the `ItemCard` class** to display each button as a tappable card with an icon and text.

7. **Implemented `onTap` actions** for each button using `InkWell` to show a `SnackBar` message when pressed.

8. **Updated the `build` method** in `MyHomePage` to display the buttons using a `GridView`.

9. **Answered the required questions in `README.md`**, explaining concepts in simple terms suitable for non-programmers.

10. **Performed `git add`, `commit`, and `push` to GitHub** to save and share the project.
