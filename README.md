# Answer the following questions in the README.md in the root folder (please modify the README.md you previously created; add subheadings for each assignment):

## Explain why we need to create a model to retrieve or send JSON data. Will an error occur if we don't create a model first?

Creating a model is like making a template or blueprint for the data we expect to receive or send. Imagine you're ordering a piece of furniture online. Knowing its dimensions, color, and material helps you visualize and plan where to place it in your home. Similarly, a model in our app defines the structure of the data—what pieces of information we'll have, like names, dates, or numbers.

When our app communicates with a web service, the data is often in JSON format, which is a way of structuring data that's easy for computers to read and write. However, raw JSON data can be messy and hard to work with directly in the app. By creating a model, we can neatly convert this JSON data into objects that are easy to use within our app.

If we don't create a model first, it would be like trying to assemble furniture without instructions or a picture of the final product. While it's technically possible, it's much more difficult and prone to mistakes. Without a model, our app might not understand how to handle the data properly, which could lead to errors when trying to display or manipulate the information.

## Explain the function of the http library that you implemented for this task.

The http library acts like a mail carrier between our app and the web service (server). Just as a mail carrier delivers letters and packages between people, the http library sends requests to and receives responses from the server over the internet.

When our app needs to fetch data (like getting the latest news or user information), it uses the http library to send a request to the server. The server then sends back the data, and the http library helps our app receive and understand it.

In short, the http library enables our app to communicate over the internet, making it possible to retrieve information from web services and display it to the user.

## Explain the function of CookieRequest and why it’s necessary to share the CookieRequest instance with all components in the Flutter app.

CookieRequest is like a personal assistant that keeps track of your session when you're interacting with a website or service. It manages cookies, which are small pieces of data stored on your device that help websites remember who you are—like staying logged in or keeping items in a shopping cart.

In our app, CookieRequest handles sending requests to the server and managing these cookies. By sharing the same CookieRequest instance with all parts of the app, we ensure that every component is on the same page regarding the user's session.

This is important because:

- Consistency: All parts of the app access the same session information, so the user stays logged in across different screens.
- State Management: It helps in maintaining the user's authentication state (logged in or out) throughout the app.
- Ease of Use: Sharing a single instance simplifies the code and avoids the need to pass around session information manually.

Without sharing CookieRequest, different parts of the app might not recognize that the user is logged in, leading to a confusing experience where some features require re-authentication or don't work as expected.

## Explain the mechanism of data transmission, from input to display in Flutter.

Let's think of the app as a two-way communication system between the user and the server:

1. User Input: The user interacts with the app by entering data—like filling out a form, typing a message, or pressing a button.

2. Sending Data: The app takes this input and packages it into a request. Using tools like the http library or CookieRequest, it sends this request over the internet to the server.

3. Server Processing: The server receives the request, processes the data (perhaps saving it to a database or performing some calculations), and prepares a response.

4. Receiving Data: The app receives the server's response, which is often in JSON format.

5. Data Conversion: The app uses models to convert this raw data into usable objects. This is like unwrapping a package and organizing its contents.

6. Displaying Data: Finally, the app updates the user interface to display the new information. This could be showing a confirmation message, updating a list of items, or navigating to a new screen.

Throughout this process, the app and server work together to handle data securely and efficiently, providing a seamless experience for the user.

## Explain the authentication mechanism from login, register, to logout. Start from inputting account data in Flutter to Django’s completion of the authentication process and display of the menu in Flutter.

Authentication is like the security process of entering a building—you need to prove who you are to gain access.

Login:

1. User Input: The user opens the app and enters their username and password into the login form.

2. Sending Credentials: When they tap the "Login" button, the app sends these credentials to the server using CookieRequest.

3. Server Verification: The server (running Django) receives the credentials and checks them against its database:
- If the username and password match a registered user, the server recognizes the user.
- If not, the server responds with an error message.

4. Response Handling:
- Success: If the credentials are correct, the server sends back a success message along with session information.
- Failure: If not, it sends back an error message explaining the issue.

5. Updating the App:
- Success: The app notes that the user is now logged in and navigates to the main menu or home screen.
- Failure: The app displays an error message to the user.

Register:

1. User Input: A new user fills out the registration form with their desired username and password.

2. Sending Data: The app sends this information to the server's registration endpoint.

3. Server Processing:
- The server checks if the username is already taken.
- It verifies that the passwords match and meet any security requirements.

4. Response Handling:
- Success: If everything is in order, the server creates a new user account and sends back a success message.
- Failure: If there's an issue (like the username already exists), it sends back an error message.

5. Updating the App:
- Success: The app informs the user that registration was successful and may redirect them to the login screen.
- Failure: The app displays the error message so the user can correct the issue.

Logout:

1. User Action: The user chooses to log out, often by tapping a "Logout" button.

2. Sending Request: The app sends a logout request to the server using CookieRequest.

3. Server Processing:
- The server ends the user's session, clearing any session data.

4. Response Handling:
- The server sends back a confirmation that the user has been logged out.

5. Updating the App:
- The app updates its state to reflect that the user is no longer logged in.
- It navigates back to the login screen or a public area of the app.

Throughout the Process:

- Session Management: CookieRequest handles session cookies, ensuring that the server recognizes the user's session across different requests.
- State Sharing: By sharing the CookieRequest instance with all components, the app maintains a consistent understanding of whether the user is logged in or out.
- User Experience: The app provides feedback at each step—informing the user of successful actions or errors that need attention.

In essence, authentication in the app involves a continuous dialogue between the user's actions, the app's handling of those actions, and the server's processing and responses, all working together to ensure secure and smooth access to the app's features.

# Explain how you implement the checklist above step by step! (not just following the tutorial).

## Ensure the deployment of your Django project is running smoothly. For issues related to PWS, which cannot yet be integrated with Flutter, the Teaching Assistant Team will provide further information later. In the meantime, you are allowed to perform integration on localhost only.
    
## Implement the registration feature in the Flutter project.

## Create a login page in the Flutter project.

## Integrate the Django authentication system with the Flutter project.

## Create a custom model according to your Django application project.

## Create a page containing a list of all items available at the JSON endpoint in Django that you have deployed.

### Display the name, price, and description of each item on this page.

## Create a detail page for each item listed on the Product list page.

### This page can be accessed by tapping on any item on the Product list page.

### Display all attributes of your item model on this page.

### Add a button to return to the item list page.

## Filter the item list page to display only items associated with the currently logged-in user.
