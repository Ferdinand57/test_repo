### 5. Explain how you implemented the checklist above step-by-step.

1. **Created a new Flutter application named `bonbon_shop`.**

- Used the flutter create command to set up the project structure.

2. **Modified `main.dart`** to change the app title to "Bonbon's Shop" and adjusted the theme colors to shades of orange to match the shop's theme.



3. **Created `menu.dart`** in the `lib` directory to organize the main menu code separately from `main.dart`.



4. **Moved `MyHomePage` from `main.dart` to `menu.dart`**, adjusting it to display the shop name and a welcome message.



5. **Created a list of buttons**—View Product List, Add Product, and Logout—each with its own icon and assigned different colors to each to match the orange theme.



6. **Created the `ItemCard` class** to display each button as a tappable card with an icon and text.



7. **Implemented `onTap` actions** for each button using `InkWell` to show a `SnackBar` message when pressed.


8. **Updated the `build` method** in `MyHomePage` to display the buttons using a `GridView`.


9. **Answered the required questions in `README.md`**, explaining concepts in simple terms suitable for non-programmers.


10. **Performed `git add`, `commit`, and `push` to GitHub** to save and share the project.

