# Answer the following questions in README.md in the root folder (please modify the README.md you created earlier; add subtitles for each assignment).

## 1. What is the purpose of const in Flutter? Explain the advantages of using const in Flutter code. When should we use const, and when should it not be used?

In Flutter, the const is used to declare constants, which are values that are fixed and cannot change during the execution of the application, for example, imagine you have a recipe that always uses the same amount of ingredients every time you cook, these amounts are constant and never change, similarly, const in Flutter tells the app that certain values or widgets are unchangeable

Purpose and Advantages:

Immutability: Using const makes objects immutable, meaning they cannot be altered after they're created. This helps prevent unintended changes to data.

Performance Optimization: Flutter can optimize const widgets by instantiating them at compile-time rather than runtime. This means the app doesn't need to recreate these widgets every time they're used, improving performance.

Reduced Memory Usage: Since const widgets are reused, the app uses less memory, making it more efficient.

When to use const: Use const when you have widgets or values that do not change, regardless of how many times the widget rebuilds. For example, static text labels, icons, or decorative elements that remain the same throughout the app.

Example: const Text('Hello, World!');

When not to use const: Do not use const when the value depends on variables that can change during runtime, such as user input or data fetched from the internet. If a widget needs to update based on state changes, it should not be declared as const.

## 2. Explain and compare the usage of Column and Row in Flutter. Provide example implementations of each layout widget!

Answer:

In Flutter, Column and Row are layout widgets used to arrange child widgets vertically and horizontally, respectively.

Analogy:

    Column: Think of stacking books on top of each other to form a vertical pile. Each book represents a widget placed one after another from top to bottom.

    Row: Imagine placing books side by side on a shelf, forming a horizontal line. Each book is a widget arranged from left to right.

Usage:

    Column:
        Used to arrange widgets vertically.
        Children are placed from top to bottom.

    Row:
        Used to arrange widgets horizontally.
        Children are placed from left to right.

Example Implementations:

    Column Example:

Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('First Item'),
    Text('Second Item'),
    Text('Third Item'),
  ],
)

This code creates a vertical list of text widgets aligned to the start (left side) of the screen.

Row Example:

Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Icon(Icons.star),
    Icon(Icons.favorite),
    Icon(Icons.person),
  ],
)

This code creates a horizontal row of icons centered within the available space.

## 3. List the input elements you used on the form page in this assignment. Are there other Flutter input elements you didn’t use in this assignment? Explain!

Answer:

Input Elements Used:

In the form page of this assignment, I used the following input elements:

    TextFormField for entering the product name.
    TextFormField for entering the product descriptions.
    TextFormField for entering the product price, with validation to ensure it's a numerical value.

Other Flutter Input Elements Not Used:

    Checkbox: Allows users to select multiple options from a list.

    Radio Button: Enables users to select one option from a set of choices.

    Switch: A toggle button that switches between on and off states.

    Slider: Lets users select a value from a continuous range by sliding a thumb along a track.

    DropdownButton: Provides a list of options in a dropdown menu for users to select from.

    DatePicker: Allows users to pick a date from a calendar interface.

    TimePicker: Enables users to select a specific time.

Explanation:

I did not use these other input elements because the form requirements were limited to text and numerical inputs for product details. However, these elements are available in Flutter and can be used in situations where the app requires users to make selections or choose dates and times.

## 4. How do you set the theme within a Flutter application to ensure consistency? Did you implement a theme in your application?

Answer:

Setting the Theme:

In Flutter, you can set a theme for your application by defining a ThemeData object in the MaterialApp widget. This theme applies consistent styling across the app, such as colors, fonts, and text styles.

Analogy: It's like choosing a color scheme and font style for a document to ensure all pages look cohesive.

Implementation:

In the main.dart file, within the MaterialApp, you can set the theme property:

MaterialApp(
  title: 'My App',
  theme: ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.orange,
    ).copyWith(secondary: Colors.deepOrangeAccent),
    useMaterial3: true,
  ),
  home: MyHomePage(),
);

Explanation:

    Primary Color (primarySwatch): Sets the main color of the app, affecting app bars, buttons, etc.
    Secondary Color (secondary): Used for highlighting elements and accents.
    useMaterial3: true: Opts into the latest Material Design guidelines.

Did I Implement a Theme?

Yes, I implemented a theme in my application to ensure consistency. I chose an orange color scheme to match the branding of "Bonbon's Shop." This theme is applied throughout the app, providing a uniform look and feel.

## 5. How do you manage navigation in a multi-page Flutter application?

Answer:

In a multi-page Flutter application, navigation is managed using the Navigator widget along with routes.

Analogy: Think of navigation like a stack of books. When you open a new page, you place a new book on top of the stack. When you go back, you remove the top book, revealing the previous one.

Managing Navigation:

    Pushing a New Page:
        Use Navigator.push() to add a new page to the navigation stack.

Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => NewPage()),
);

Replacing the Current Page:

    Use Navigator.pushReplacement() to replace the current page with a new one.

Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => NewPage()),
);

Popping a Page:

    Use Navigator.pop() to go back to the previous page.

    Navigator.pop(context);

Using a Drawer for Navigation:

    A Drawer provides a consistent navigation menu across the app.

    It contains options that, when tapped, navigate to different pages using the Navigator.

Implementation in My Application:

I managed navigation using both the Navigator widget and a Drawer menu.

    Drawer Navigation:

        The drawer contains options like "Home Page" and "Add Product."

        Tapping these options uses Navigator.pushReplacement() to navigate to the respective pages.

    Button Navigation:
        On the main page, the "Add Product" button uses Navigator.push() to navigate to the form page.

This setup allows users to move between different pages smoothly.

# The checklist for this assignment is as follows:


## Create at least one new page in the application, specifically a form page to add a new item with the following requirements:


### Use at least three input elements: name, amount, and description. Add input elements according to the model in your previous Django project.

### Include a Save button.

### Each input element in the form must also be validated with the following criteria:


- No input field should be left empty.

- Each input field must contain data in the model's data type.

warning: Pay attention to cases such as negative numbers, minimum string length (if applicable), maximum string length (if applicable), and so on. It's not just about data types!

## Redirect the user to the new item addition form when they press the Add Item button on the main page.

## Display the data from the form in a pop-up after pressing the Save button on the new item addition form page.

## Create a drawer in the application with the following requirements:

- The drawer should contain at least two options: Home and Add Item.

- when selecting the Home option, the application should redirect the user to the main page.

- When selecting the Add Item option, the application should redirect the user to the new item addition form page.

