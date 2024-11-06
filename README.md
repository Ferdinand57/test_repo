# Answer the following questions in README.md in the root folder (please modify the README.md you created earlier; add subtitles for each assignment).
## 1. What is the purpose of const in Flutter? Explain the advantages of using const in Flutter code. When should we use const, and when should it not be used?



## 2. Explain and compare the usage of Column and Row in Flutter. Provide example implementations of each layout widget!



## 3. List the input elements you used on the form page in this assignment. Are there other Flutter input elements you didn’t use in this assignment? Explain!



## 4. How do you set the theme within a Flutter application to ensure consistency? Did you implement a theme in your application?



## 5. How do you manage navigation in a multi-page Flutter application?




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

### The drawer should contain at least two options: Home and Add Item.
### When selecting the Home option, the application should redirect the user to the main page.
### When selecting the Add Item option, the application should redirect the user to the new item addition form page.

