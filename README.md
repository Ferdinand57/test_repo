## Integration with the web service to connect to the web application created in the midterm project

### How we integrate the web service to connect to the web application

1. Deploy the django-based application to the web service, in this case we use Vercel

By deploying our django-based application, we are bringing our web application online, which enable us to access all of it's features and database with our flutter application

2.  Connect our flutter application to the web application by referencing the link to our current active web application

We are able to do this by using the function "final response = await request.", for example with the following code (not the exact code that we will use):

```
final response = await request.get('http://127.0.0.1:8000/json/');
final response = await request.login("http://127.0.0.1:8000/auth/login/", {'username': username,'password': password,});
final response = await request.postJson("http://127.0.0.1:8000/create-flutter/",jsonEncode(<String, String>{'name': _name,'price': _price.toString(),'description': _description,}),
final response = await request.postJson("http://127.0.0.1:8000/auth/register/",jsonEncode({"username": username,"password1": password1,"password2": password2,}));
final response = await request.logout("http://127.0.0.1:8000/auth/logout/");
```

By using the function, we are able to integrate our flutter application with our web service, which allows us to use it's function within our mobile application

### Restaurants Module

Interaction with Web Service:
        
- Fetching Restaurant Data: The application sends HTTP GET requests to the web service's API endpoints to retrieve a list of restaurants. This includes details like restaurant names, locations, cuisines, price ranges, menus, photos, operating hours, and contact information.

- Filtering and Sorting: Users can apply filters or sorting options, which are sent as query parameters in the GET requests. The web service processes these parameters and returns the filtered and sorted list of restaurants.

### Authentication Module

Interaction with Web Service:
- User Registration: The app allows new users to register by sending HTTP POST requests with their information to the web service, which creates new user accounts.
- User Login: Users can log in by sending their credentials via HTTP POST requests. The web service authenticates the user and establishes a session or provides a token.
- User Logout: Users can log out, and the app will notify the web service to terminate the session.


### Reviews Module

Interaction with Web Service:
- Submitting Reviews: Authenticated users can submit reviews for restaurants by sending HTTP POST requests with review content, ratings, and the restaurant ID.
- Fetching Reviews: The app retrieves reviews for a specific restaurant by sending HTTP GET requests. The web service returns all reviews associated with that restaurant.

### Maps Module

Interaction with Web Service:
- Fetching Location Data: The app uses the location data (latitude and longitude) of restaurants retrieved from the web service to display them on a map.
- Nearby Restaurants: By utilizing the user's current location, the app can calculate and display nearby restaurants. This can be enhanced by sending the user's location to the web service to get a list of nearby restaurants.

### Admin Dashboard Module

Interaction with Web Service:
- Managing Restaurants: Admin users can add, edit, or delete restaurant data by sending HTTP POST, PUT/PATCH, or DELETE requests to the web service.
- Managing Users: Admins can manage user accounts via API endpoints provided by the web service.

### Navigation Module

Interaction with Web Service:
- Dynamic Content Loading: The navigation module may request data from the web service to display dynamic menu options or notifications.
- Session Management: It utilizes authentication status to adjust available navigation options (e.g., showing admin options only to admin users).




