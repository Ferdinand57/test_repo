# The checklist for this assignment is as follows:


## Create at least one new page in the application, specifically a form page to add a new item with the following requirements:

In this assignment, we have a dedicated page to add a product with the following code:

productentry_form.dart
```
import 'package:flutter/material.dart';
// Impor drawer widget
import 'package:bonbon_shop/widgets/left_drawer.dart';

class ProductEntryFormPage extends StatefulWidget {
  const ProductEntryFormPage({super.key});

  @override
  State<ProductEntryFormPage> createState() => _ProductEntryFormPageState();
}

class _ProductEntryFormPageState extends State<ProductEntryFormPage> {
  final _formKey = GlobalKey<FormState>();
	String _product = "";
	String _descriptions = "";
	int _productIntensity = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Your Product Today',
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      // Add drawer as a parameter value for the drawer attribute of the Scaffold widget
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Product",
                    labelText: "Product",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _product = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Product cannot be empty!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Descriptions",
                    labelText: "Descriptions",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _descriptions = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Descriptions cannot be empty!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Product price",
                    labelText: "Product price",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _productIntensity = int.tryParse(value!) ?? 0;
                    });
                  },
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
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          Theme.of(context).colorScheme.primary),
                    ),
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
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
```

### Use at least three input elements: name, amount, and description. Add input elements according to the model in your previous Django project.

We implement the input elements with the following code:

productentry_form.dart
```
...
class _ProductEntryFormPageState extends State<ProductEntryFormPage> {
  final _formKey = GlobalKey<FormState>();
	String _product = "";
	String _descriptions = "";
	int _productIntensity = 0;
...
```

### Include a Save button.

We implement the save button with the following code:

productentry_form.dart
```
...
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
...
```

### Each input element in the form must also be validated with the following criteria:


- No input field should be left empty.

- Each input field must contain data in the model's data type.

we validate the input field with the following code:

productentry_form.dart
```
              ...
              Padding(
                ...
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Product cannot be empty!";
                    }
                    return null;
                ...
                ),
              ),
              Padding(
                ...
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Descriptions cannot be empty!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                ...
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
                ),
              ),
```

warning: Pay attention to cases such as negative numbers, minimum string length (if applicable), maximum string length (if applicable), and so on. It's not just about data types!

## Redirect the user to the new item addition form when they press the Add Item button on the main page.

We implement the feature above with the following code:

product_card.dart
```
      ...
      child: InkWell(
        // Touch-responsive area
        onTap: () {
          ...
          // Navigate to the appropriate route (depending on the button type)
          if (item.name == "Add Product") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProductEntryFormPage()));
          }
        },
        ...
```

## Display the data from the form in a pop-up after pressing the Save button on the new item addition form page.

We implement the feature by the following code:

productentry_form.dart
```
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          Theme.of(context).colorScheme.primary),
                    ),
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
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
```

## Create a drawer in the application with the following requirements:

- The drawer should contain at least two options: Home and Add Item.

- when selecting the Home option, the application should redirect the user to the main page.

- When selecting the Add Item option, the application should redirect the user to the new item addition form page.

we achive implement the above by doing the following piece of code:

```
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home Page'),
            // Redirection part to MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_business_outlined),
            title: const Text('Add Product'),
            // Redirection part to ProductEntryFormPage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductEntryFormPage(),
                  ));
            },
          ),
```
