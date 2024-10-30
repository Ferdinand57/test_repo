# Bonbon's Shop

Step-by-Step Instructions
Step 1: Create a New Flutter Application Named bonbon_shop

    Open your terminal or command prompt.

    Run the following commands to create a new Flutter project and navigate into it:

    bash

    flutter create bonbon_shop
    cd bonbon_shop

    This creates a new Flutter application in a folder named bonbon_shop.

Step 2: Modify the Application Theme Color in main.dart

    Open the lib/main.dart file in your code editor.

    Change the application theme colors to match Bonbon's Shop branding with an orange theme.

    Replace the existing colorScheme in the MaterialApp widget with:

    dart

    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.orange,
    ).copyWith(secondary: Colors.deepOrangeAccent),

    This sets the primary color to orange and the secondary color to deep orange accent.

Step 3: Reorganize the Project Structure by Creating menu.dart

    In the lib directory, create a new file named menu.dart.

    At the top of menu.dart, add the following import statement:

    dart

    import 'package:flutter/material.dart';

Step 4: Move MyHomePage Widget to menu.dart and Adjust It

    Cut the MyHomePage class from main.dart and paste it into menu.dart.

    In main.dart, update the home property of MaterialApp to:

    dart

home: MyHomePage(),

Add the following import at the top of main.dart:

dart

import 'package:bonbon_shop/menu.dart';

In menu.dart, modify MyHomePage to be a stateless widget:

dart

    class MyHomePage extends StatelessWidget {
      MyHomePage({super.key});

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          // Will add content here in the next steps.
        );
      }
    }

    Remove any state-related code, constructors, and the createState() method.

Step 5: Create Variables for Shop Information

    Inside the MyHomePage class in menu.dart, declare a variable for Bonbon's Shop:

    dart

    final String shopName = 'Bonbon\'s Shop'; // Shop name

Step 6: Create Buttons with Icons and Texts

    Create a class ItemHomepage to define the buttons:

    dart

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}

In MyHomePage, create a list of ItemHomepage instances with different colors:

dart

    final List<ItemHomepage> items = [
      ItemHomepage("View Product List", Icons.list, Colors.orangeAccent),
      ItemHomepage("Add Product", Icons.add_shopping_cart, Colors.deepOrange),
      ItemHomepage("Logout", Icons.logout, Colors.brown),
    ];

Step 7: Create ItemCard Class to Display the Buttons

    In menu.dart, create the ItemCard class:

    dart

    class ItemCard extends StatelessWidget {
      final ItemHomepage item;

      const ItemCard(this.item, {super.key});

      @override
      Widget build(BuildContext context) {
        return Material(
          color: item.color,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text("You have pressed the ${item.name} button.")),
                );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item.icon,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }

    This class creates a colored button with an icon and text that shows a Snackbar when tapped.

Step 8: Integrate ItemCard into MyHomePage

    Update the build method in MyHomePage:

    dart

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            shopName,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                    'Welcome to Bonbon\'s Shop',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                GridView.count(
                  primary: true,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  children: items.map((ItemHomepage item) {
                    return ItemCard(item);
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      );
    }

    This integrates the ItemCard into the main page, displaying the buttons.

Step 9: Enable Web Support and Run the Application

    Before running the application on Chrome, enable web support (if you haven't already):

    bash

flutter config --enable-web

Run the application on Chrome:

bash

    flutter run -d chrome

    This will launch your bonbon_shop application in the Chrome browser.

Step 10: Add, Commit, and Push to GitHub

    Initialize Git in your project directory if you haven't already:

    bash

git init

Add all changes:

bash

git add .

Commit your changes with a message:

bash

git commit -m "Implemented Bonbon's Shop Flutter application with orange theme"

Push to your GitHub repository (replace <branch_name> with your branch name):

bash

git push -u origin <branch_name>

Make sure you have set up a remote repository on GitHub and linked it to your local project.

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
