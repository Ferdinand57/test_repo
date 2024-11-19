# Explain how you implement the checklist above step by step! (not just following the tutorial).

### Ensure the deployment of your Django project is running smoothly. For issues related to PWS, which cannot yet be integrated with Flutter, the Teaching Assistant Team will provide further information later. In the meantime, you are allowed to perform integration on localhost only.
    
## Implement the registration feature in the Flutter project.

I added a registration feature to allow new users to create accounts directly from the Flutter app

- I created a new file named register.dart in the lib/screens/ directory of the Flutter project, this page contains a form where users can input their desired username and password

- In register.dart, I imported the necessary packages, including pbp_django_auth for handling authentication and provider for state management
```
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bonbon_shop/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
```

- The RegisterPage class defines the registration page, with controllers to handle input from the username and password fields
```
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    // UI code for the registration form
  }
}
```
The main function of this code is to create a user interface for registration and to handle user input through text fields

- When the user taps the "Register" button, the app captures the inputted username and passwords, then it sends a POST request to the Django server's registration endpoint to create a new user
```
ElevatedButton(
  onPressed: () async {
    String username = _usernameController.text;
    String password1 = _passwordController.text;
    String password2 = _confirmPasswordController.text;

    // Sending the registration data to the server
    final response = await request.postJson(
      "http://127.0.0.1:8000/auth/register/",
      jsonEncode({
        "username": username,
        "password1": password1,
        "password2": password2,
      }),
    );

    if (context.mounted) {
      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully registered!'),
          ),
        );
        // Navigate to the login page after successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to register!'),
          ),
        );
      }
    }
  },
  // Button styling code
)
```
This code handles the main function of sending registration data to the server and processing the server's response. If registration is successful, it shows a success message and navigates the user to the login page. If it fails, it displays an error message


## Create a login page in the Flutter project.

I implemented a login page to allow existing users to access their accounts

- I created a new file named login.dart in the lib/screens/ directory, this page contains a form for users to enter their username and password

- In login.dart, I imported necessary packages and created controllers for the input fields
```
import 'package:bonbon_shop/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bonbon_shop/screens/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    // UI code for the login form
  }
}

```
The main function of this code is to create a user interface for login and to handle user input through text fields

- When the "Login" button is tapped, the app sends the entered credentials to the Django server for authentication
```
ElevatedButton(
  onPressed: () async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Sending login credentials to the server
    final response = await request.login(
      "http://127.0.0.1:8000/auth/login/",
      {
        'username': username,
        'password': password,
      },
    );

    if (request.loggedIn) {
      String message = response['message'];
      String uname = response['username'];
      if (context.mounted) {
        // Navigate to the home page after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text("$message Welcome, $uname.")),
          );
      }
    } else {
      if (context.mounted) {
        // Show error message if login fails
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Login Failed'),
            content: Text(response['message']),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      }
    }
  },
  // Button styling code
)

```
This code performs the main function of authenticating the user. It sends the username and password to the server, and depending on the server's response, it either logs the user in and navigates to the home page or displays an error message

## Integrate the Django authentication system with the Flutter project.

Integration was achieved by ensuring that the Flutter app could communicate with the Django server and maintain session state

- I used the pbp_django_auth package to handle authentication and session management between Flutter and Django

- In the main.dart file, I set up a Provider to share an instance of CookieRequest with all components of the app
```
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:bonbon_shop/screens/login.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'Bonbon\'s Shop',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.orange,
          ).copyWith(secondary: Colors.deepOrangeAccent),
        ),
        home: LoginPage(),
      ),
    );
  }
}

```
The main function of this code is to provide the CookieRequest instance to the entire app, allowing all parts of the app to access session information and maintain authentication state

- In each page where authenticated requests are needed, I accessed the CookieRequest instance using context.watch<CookieRequest>()
```
@override
Widget build(BuildContext context) {
  final request = context.watch<CookieRequest>();
  // Rest of the build method
}
```
This allows the app to include session cookies in HTTP requests, ensuring that the server recognizes the user's session

## Create a custom model according to your Django application project.

I created a custom model in Flutter to match the data structure of the Django models, facilitating data handling in the app

- I used Quicktype to generate Dart model code based on a sample JSON response from the Django endpoint

- I created a new file named product_entry.dart in the lib/models/ directory
```
import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) => List<ProductEntry>.from(json.decode(str).map((x) => ProductEntry.fromJson(x)));

String productEntryToJson(List<ProductEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductEntry {
  String model;
  String pk;
  Fields fields;

  ProductEntry({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
    model: json["model"],
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  int user;
  String name;
  DateTime time;
  String price;
  String description;

  Fields({
    required this.user,
    required this.name,
    required this.time,
    required this.price,
    required this.description,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    user: json["user"],
    name: json["name"],
    time: DateTime.parse(json["time"]),
    price: json["price"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "name": name,
    "time": "${time.year.toString().padLeft(4, '0')}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')}",
    "price": price,
    "description": description,
  };
}

```
The main function of this code is to define the structure of the product data. It provides methods to convert JSON data into Dart objects (fromJson) and vice versa (toJson), making it easier to work with product data in the app

## Create a page containing a list of all items available at the JSON endpoint in Django that you have deployed.

I created a product list page to display all products retrieved from the Django backend

- I created a new file named list_productentry.dart in the lib/screens/ directory
```
import 'package:flutter/material.dart';
import 'package:bonbon_shop/models/product_entry.dart';
import 'package:bonbon_shop/widgets/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bonbon_shop/screens/product_detail.dart';

class ProductEntryPage extends StatefulWidget {
  const ProductEntryPage({super.key});

  @override
  State<ProductEntryPage> createState() => _ProductEntryPageState();
}

class _ProductEntryPageState extends State<ProductEntryPage> {
  Future<List<ProductEntry>> fetchProduct(CookieRequest request) async {
    // Fetching product data from the Django server
    final response = await request.get('http://127.0.0.1:8000/json/');
    var data = response;
    List<ProductEntry> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(ProductEntry.fromJson(d));
      }
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    // UI code to display the list of products
  }
}

```
The main function of this code is to fetch product data from the server and display it in a list


### Display the name, price, and description of each item on this page.

In the ListView.builder, I displayed the name, price, and description of each product
```
return ListView.builder(
  itemCount: snapshot.data!.length,
  itemBuilder: (_, index) => GestureDetector(
    onTap: () {
      // Navigate to the product detail page when tapped
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailPage(
            product: snapshot.data![index],
          ),
        ),
      );
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${snapshot.data![index].fields.name}",
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text("${snapshot.data![index].fields.description}"),
          const SizedBox(height: 10),
          Text("Price: ${snapshot.data![index].fields.price}"),
        ],
      ),
    ),
  ),
);

```
This code performs the main function of displaying the product details in a list format. Each item includes the product name, description, and price

## Create a detail page for each item listed on the Product list page.

I implemented a detail page to show all attributes of a product when it is selected from the list

- This page can be accessed by tapping on any item on the Product list page.
- Display all attributes of your item model on this page.
- Add a button to return to the item list page.

I created a new file named product_detail.dart in the lib/screens/ directory
```
import 'package:flutter/material.dart';
import 'package:bonbon_shop/models/product_entry.dart';
import 'package:bonbon_shop/screens/list_productentry.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntry product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.fields.name,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              "Description:",
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              product.fields.description,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              "Price: ${product.fields.price}",
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              "Date Added: ${product.fields.time.toLocal()}",
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the product list page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductEntryPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: const Text(
                "Back to Product List",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

The main function of this code is to display all details of a selected product, including name, description, price, and date added. It also provides a button to return to the product list page

In list_productentry.dart, I added navigation to the detail page when a product is tapped
```
onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProductDetailPage(
        product: snapshot.data![index],
      ),
    ),
  );
},

```
This allows users to tap on a product in the list and view its detailed information

## Filter the item list page to display only items associated with the currently logged-in user.

To ensure that users see only their own products, I made changes to both the backend and frontend

- In the Django view that returns the JSON data, I filtered the products by the logged-in user
```
def product_list_json(request):
    if request.user.is_authenticated:
        products = Product.objects.filter(user=request.user)
        # Return JSON response
    else:
        # Return empty response or error

```
The main function of this code is to retrieve only the products that belong to the authenticated user, ensuring that users see only their own data

Since the backend now returns only the user's products, the Flutter app automatically displays only those items in the product list page
