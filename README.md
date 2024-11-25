## Integration with the web service to connect to the web application created in the midterm project

### Restaurants Module

Interaction with Web Service:
        
- Fetching Restaurant Data: The application sends HTTP GET requests to the web service's API endpoints to retrieve a list of restaurants. This includes details like restaurant names, locations, cuisines, price ranges, menus, photos, operating hours, and contact information.

- Filtering and Sorting: Users can apply filters or sorting options, which are sent as query parameters in the GET requests. The web service processes these parameters and returns the filtered and sorted list of restaurants.

Endpoints Used:
- GET /: Retrieve all restaurants.
- GET /ajax/?filter_params: Retrieve restaurants based on filters (e.g., cuisine type, price range).

Notes:
- The base URL / serves the RestaurantListView, which provides the list of all restaurants.
- The endpoint /ajax/ is used for AJAX requests, allowing dynamic fetching of restaurant data based on filters applied by the user.

### Authentication Module

Interaction with Web Service:
- User Registration: The app allows new users to register by sending HTTP POST requests with their information to the web service, which creates new user accounts.
- User Login: Users can log in by sending their credentials via HTTP POST requests. The web service authenticates the user and establishes a session or provides a token.
- User Logout: Users can log out, and the app will notify the web service to terminate the session.

Endpoints Used:
- POST /auth/register/: Register a new user.
- POST /auth/login/: Authenticate a user.
- POST /auth/logout/: Log out the user.
- GET /auth/customization/: Access user customization settings.
- POST /auth/customization/: Update user customization settings.

Notes:
- All authentication-related endpoints are prefixed with /auth/ as per the main URL configuration.
- Sessions are managed by the Django authentication framework.

### Reviews Module

Interaction with Web Service:
- Submitting Reviews: Authenticated users can submit reviews for restaurants by sending HTTP POST requests with review content, ratings, and the restaurant ID.
- Fetching Reviews: The app retrieves reviews for a specific restaurant by sending HTTP GET requests. The web service returns all reviews associated with that restaurant.

Endpoints Used:
- POST /reviews/restaurant/<int:restaurant_id>/add_review/: Submit a review for a restaurant.
- GET /reviews/restaurant/<int:restaurant_id>/: Get details and reviews for a restaurant.
- POST /reviews/restaurant/<int:restaurant_id>/like/: Like a restaurant.
- POST /reviews/restaurant/<int:restaurant_id>/dislike/: Dislike a restaurant.

Notes:
- The <int:restaurant_id> parameter is the ID of the restaurant for which the action is being performed.
- The reviews module handles both the submission of new reviews and the retrieval of existing ones.

### Maps Module

Interaction with Web Service:
- Fetching Location Data: The app uses the location data (latitude and longitude) of restaurants retrieved from the web service to display them on a map.
- Nearby Restaurants: By utilizing the user's current location, the app can calculate and display nearby restaurants. This can be enhanced by sending the user's location to the web service to get a list of nearby restaurants.

Endpoints Used:
- GET /map/: Retrieve the map view with restaurant locations.

Notes:
- The /map/ endpoint serves the RestaurantMapView, which provides the necessary data to display restaurants on a map.
- The module may utilize data from the Restaurants Module for detailed restaurant information.

### Admin Dashboard Module

Interaction with Web Service:
- Managing Restaurants: Admin users can add, edit, or delete restaurant data by sending HTTP POST, PUT/PATCH, or DELETE requests to the web service.
- Managing Users: Admins can manage user accounts via API endpoints provided by the web service.

Endpoints Used:

Restaurant Management:
- GET /admin-dashboard/restaurants/: List all restaurants (admin view).
- POST /admin-dashboard/restaurants/add/: Add a new restaurant.
- PUT/PATCH /admin-dashboard/restaurants/update/<int:pk>/: Update restaurant details.
- DELETE /admin-dashboard/restaurants/delete/<int:pk>/: Delete a restaurant.
- POST /admin-dashboard/delete/: Batch delete restaurants.

User Management:
- GET /admin-dashboard/users/: List all users.
- POST /admin-dashboard/users/add/: Add a new user.
- PUT/PATCH /admin-dashboard/users/update/<int:pk>/: Update user details.
- DELETE /admin-dashboard/users/delete/<int:pk>/: Delete a user.
- POST /admin-dashboard/users/delete/: Batch delete users.

Notes:
The <int:pk> parameter represents the primary key (ID) of the restaurant or user.
All admin-related endpoints are prefixed with /admin-dashboard/ and require appropriate admin permissions.

### Navigation Module

Interaction with Web Service:
- Dynamic Content Loading: The navigation module may request data from the web service to display dynamic menu options or notifications.
- Session Management: It utilizes authentication status to adjust available navigation options (e.g., showing admin options only to admin users).

Endpoints Used:

Depends on Specific Implementation:

May use endpoints from other modules, such as the Authentication Module to check user roles, and display appropriate navigation items.

For example, accessing /auth/customization/ to personalize the navigation experience.

Notes:

The Navigation Module does not have dedicated endpoints but interacts with existing ones to provide a dynamic user interface.

It ensures that users only see the navigation options relevant to their role (Guest, Customer, Admin).
