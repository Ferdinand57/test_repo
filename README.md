# Answer the following questions in README.md in the root folder (please modify the README.md you created earlier; add subtitles for each assignment).

## 1. What is the purpose of const in Flutter? Explain the advantages of using const in Flutter code. When should we use const, and when should it not be used?

In Flutter, the const is used to declare constants, which are values that are fixed and cannot change during the execution of the application, for example, imagine you have a recipe that always uses the same amount of ingredients every time you cook, these amounts are constant and never change, similarly, const in Flutter tells the application that certain values or widgets are unchangeable

Using const makes objects immutable, meaning they cannot be altered after they're created, this helps prevent unintended changes to data. Flutter can make apps faster by creating certain widgets in advance, before the app runs, this way, it doesn’t have to remake these widgets every time they're used, which helps the app run more smoothly. Since const widgets are reused, the app uses less memory, making it more efficient.

When to use const: Use const when you have widgets or values that do not change, regardless of how many times the widget rebuilds. For example, static text labels, icons, or decorative elements that remain the same throughout the app.

Example: const Text('Hello, World!');

When not to use const: Do not use const when the value depends on variables that can change during runtime, such as user input. If a widget needs to update based on state changes, it should not be declared as const.

## 2. Explain and compare the usage of Column and Row in Flutter. Provide example implementations of each layout widget!

In Flutter, Column and Row are layout widgets used to arrange child widgets vertically and horizontally. Think of it like stacking books on top of each other to form a vertical pile, where each book represents a widget placed one after another from top to bottom. Now imagine placing books side by side on a shelf, forming a horizontal line. Each book is a widget arranged from left to right.

Column is used to arrange widgets vertically, where children are placed from top to bottom. While row is used to arrange widgets horizontally, where children are placed from left to right.

Example Implementations:
```
Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    // descriptions to display 3 InfoCard horizontally.
    descriptions(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InfoCard(title: 'NPM', content: npm),
        InfoCard(title: 'Name', content: name),
        InfoCard(title: 'Class', content: className),
      ],
    ),
```
The code above creates a vertical list of text widgets aligned to the start (left side) of the screen.
```
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Icon(Icons.star),
    Icon(Icons.favorite),
    Icon(Icons.person),
  ],
)
```
The code above creates a horizontal row of icons centered within the available space.

## 3. List the input elements you used on the form page in this assignment. Are there other Flutter input elements you didn’t use in this assignment? Explain!

In the form page of this assignment, i used the following input elements:

- TextFormField for entering the product name.
- TextFormField for entering the product descriptions.
- TextFormField for entering the product price, with validation to ensure it's a numerical value.

Other flutter input elements not used:

- Checkbox: Allows users to select multiple options from a list.
- Radio Button: Enables users to select one option from a set of choices.
- Switch: A toggle button that switches between on and off states.
- Slider: Lets users select a value from a continuous range by sliding a thumb along a track.
- DropdownButton: Provides a list of options in a dropdown menu for users to select from.
- DatePicker: Allows users to pick a date from a calendar interface.
- TimePicker: Enables users to select a specific time.

I did not use these other input elements because the form requirements were limited to text and numerical inputs for product details, however, these elements are available in Flutter and can be used in situations where the app requires users to make selections or choose dates and times

## 4. How do you set the theme within a Flutter application to ensure consistency? Did you implement a theme in your application?

In Flutter, you can set a theme for your application by defining a ThemeData object in the MaterialApp widget. This theme applies consistent styling across the app, such as colors, fonts, and text styles, for example, it's like choosing a color scheme and font style for a document to ensure all pages look cohesive.

In the main.dart file, within the MaterialApp, I set the theme property with the following code:
```
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bonbon\'s Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.orange,
        ).copyWith(secondary: Colors.deepOrangeAccent),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

```

- Primary Color (primarySwatch): Sets the main color of the app, affecting app bars, buttons, etc.
- Secondary Color (secondary): Used for highlighting elements and accents.
- useMaterial3: true: Opts into the latest Material Design guidelines.

I implemented a theme in my application to ensure consistency. I chose an orange color scheme to match the branding of "Bonbon's Shop." This theme is applied throughout the app, providing a uniform look and feel.


## 5. How do you manage navigation in a multi-page Flutter application?

In a multi-page Flutter application, navigation is managed using the Navigator widget along with routes, think of navigation like a stack of books, when you open a new page, you place a new book on top of the stack, when you go back, you remove the top book, revealing the previous one.

- Pushing a New Page:
        
Use Navigator.push() to add a new page to the navigation stack.
```
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => NewPage()),
);
```

- Replacing the Current Page:

Use Navigator.pushReplacement() to replace the current page with a new one.
```
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => NewPage()),
);
```

- Popping a Page:

Use Navigator.pop() to go back to the previous page.
```
Navigator.pop(context);
```

- Using a Drawer for Navigation:

A Drawer provides a consistent navigation menu across the app. It contains options that, when tapped, navigate to different pages using the Navigator.

In my application, I managed navigation using both the Navigator widget and a Drawer menu.

- Drawer Navigation: The drawer contains options like "Home Page" and "Add Product." Tapping these options uses Navigator.pushReplacement() to navigate to the respective pages.
- Button Navigation: On the main page, the "Add Product" button uses Navigator.push() to navigate to the form page.
 
This setup allows users to move between different pages smoothly.

# The checklist for this assignment is as follows:

## Create at least one new page in the application, specifically a form page to add a new item with the following requirements:

I created a new page called ProductEntryFormPage in the productentry_form.dart file. This page allows users to input details about a new product they want to add to the shop. The page is a StatefulWidget, which means it can maintain state changes, such as form input values. The Scaffold widget provides the basic layout with an AppBar and a Form in the body.

Code:
```
class ProductEntryFormPage extends StatefulWidget {
  const ProductEntryFormPage({super.key});

  @override
  State<ProductEntryFormPage> createState() => _ProductEntryFormPageState();
}
```

### Use at least three input elements: name, amount, and description. Add input elements according to the model in your previous Django project.

I included three TextFormField widgets in the form for:

- Product Name (_product): Captures the name of the product.
- Descriptions (_descriptions): Allows the user to provide a description of the product.
- Product Price (_productIntensity): Collects the price of the product, ensuring it is a numerical value.

These fields correspond to the data model used in the previous Django project, ensuring consistency across applications.

Code:
```
String _product = "";
String _descriptions = "";
int _productIntensity = 0;
```

### Include a Save button.

I added an ElevatedButton widget labeled "Save." The button is placed inside an Align and Padding widget to position it correctly. When pressed, it triggers the form validation and displays the entered data.

Code:
```
ElevatedButton(
  onPressed: () {
    if (_formKey.currentState!.validate()) {
      // Show dialog with entered data
    }
  },
  child: const Text(
    "Save",
    style: TextStyle(color: Colors.white),
  ),
),
```

### Each input element in the form must also be validated with the following criteria:

- No input field should be left empty.

- Each input field must contain data in the model's data type.

warning: Pay attention to cases such as negative numbers, minimum string length (if applicable), maximum string length (if applicable), and so on. It's not just about data types!

I added validator functions to each TextFormField to ensure:

- No Empty Fields: Each field checks if the input is null or empty and returns an error message if so.
- Correct Data Types: For the product price, I added additional validation to ensure the input is a positive integer.
- Additional Constraints: The price cannot be negative, handling cases beyond just data types.

Code:
```
validator: (String? value) {
  if (value == null || value.isEmpty) {
    return "Product cannot be empty!";
  }
  return null;
},

For the product price:

validator: (String? value) {
  if (value == null || value.isEmpty) {
    return "Product price cannot be empty!";
  }
  int? price = int.tryParse(value);
  if (price == null) {
    return "Product price must be a number!";
  }
  if (price < 0) {
    return "Product price cannot be negative!";
  }
  return null;
},
```

## Redirect the user to the new item addition form when they press the Add Item button on the main page.

I modified the onTap function of the "Add Product" button in product_card.dart to navigate to the ProductEntryFormPage. I used Navigator.push() to add the form page onto the navigation stack, allowing users to return to the main page using the back button.

Code:
```
if (item.name == "Add Product") {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ProductEntryFormPage()),
  );
}
```

## Display the data from the form in a pop-up after pressing the Save button on the new item addition form page.

I implemented a showDialog() function that shows an AlertDialog when the form is successfully validated and the Save button is pressed.

- The dialog displays the entered product information.
- It includes an OK button that closes the dialog and resets the form.

Code:
```
onPressed: () {
  if (_formKey.currentState!.validate()) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Product successfully saved'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Product: $_product'),
                Text('Descriptions: $_descriptions'),
                Text('Product price: $_productIntensity \$'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                _formKey.currentState!.reset();
              },
            ),
          ],
        );
      },
    );
  }
},
```

## Create a drawer in the application with the following requirements:

- The drawer should contain at least two options: Home and Add Item.
- when selecting the Home option, the application should redirect the user to the main page.
- When selecting the Add Item option, the application should redirect the user to the new item addition form page.

I created a LeftDrawer widget in left_drawer.dart that contains navigation options.

Drawer Structure:
- Contains a DrawerHeader with the application's title and a brief description.
- Includes two ListTile widgets representing the Home and Add Product options.

Navigation Logic:
- Used Navigator.pushReplacement() in the onTap functions to navigate to the appropriate pages.
- This replaces the current page with the new one, keeping the navigation stack clean.

Code:
```
ListTile(
  leading: const Icon(Icons.home_outlined),
  title: const Text('Home Page'),
  onTap: () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(),
      ),
    );
  },
),
ListTile(
  leading: const Icon(Icons.add_business_outlined),
  title: const Text('Add Product'),
  onTap: () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProductEntryFormPage(),
      ),
    );
  },
),
```
By implementing the drawer, users can easily navigate between the main page and the form page from anywhere in the app.
