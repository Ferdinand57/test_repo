## Integration with the Web Service to Connect to the Web Application Created in the Midterm Project

### Restaurants Module

Interaction with Web Service:
- Fetching Restaurant Data: The application sends HTTP GET requests to retrieve a list of restaurants, including details like names, locations, cuisines, price ranges, menus, photos, operating hours, and contact information.

- Filtering and Sorting: Users can apply filters or sorting options sent as query parameters. The web service processes these and returns the filtered and sorted list.

Endpoints Used:

- Retrieve All Restaurants: Retrieve a paginated list of all restaurants (GET /)
Parameters:
-- page (optional): The page number for pagination.

- Retrieve Restaurants with Filters: Retrieve restaurants based on search terms and selected cuisines (GET /?search=<search_term>&search_by=<search_field>&cuisines=<cuisine1>&cuisines=<cuisine2>&...)
Parameters:
-- search (optional): The search term entered by the user.
-- search_by (optional): Field to search by (name or cuisine). Default is name.
- cuisines (optional): List of cuisines to filter by (can be multiple).
- page (optional): The page number for pagination.

- Retrieve Restaurants via AJAX: Dynamically update restaurant listings without reloading the page (GET /ajax/?   search=<search_term>&search_by=<search_field>&cuisines=<cuisine1>&...)
-- Parameters: Same as above.

Details from Views:

RestaurantListView in restaurants/views.py handles the requests and processes query parameters.
Pagination is managed with paginate_by = 9.

### Authentication Module

Interaction with Web Service:

User Registration: New users register by sending HTTP POST requests with their information.

User Login: Users log in by sending credentials via HTTP POST. The web service authenticates the user and establishes a session.

User Logout: Users log out, and the app notifies the web service to terminate the session.

User Customization: Authenticated users access and update their settings.

Endpoints Used:

User Login: Authenticate a user and start a session (POST /auth/login/)
Parameters:
username: The user's username.
password: The user's password.

User Logout: Log out the user and end the session (POST /auth/logout/)

User Registration: Register a new user account (POST /auth/register/)
Parameters:
username: Desired username.
password1: Password.
password2: Password confirmation.

User Customization (Access Settings): Retrieve user-specific data (GET /auth/customization/)

User Customization (Update Settings): Update user customization settings (POST /auth/customization/)
Parameters:
Depends on the customization options available.

Details from Views:

Functions in authentication/views.py handle authentication processes.
CustomUserCreationForm is used for registration.
user_customization view allows access to personalized data.

### Reviews Module

Interaction with Web Service:

Submitting Reviews: Authenticated users submit reviews by sending HTTP POST requests with review content, ratings, and the restaurant ID.

Fetching Reviews: The app retrieves reviews for a restaurant via HTTP GET requests.

Liking/Disliking Restaurants: Users like or dislike a restaurant via POST requests.

Endpoints Used:

Get Restaurant Details and Reviews: Retrieve restaurant details and reviews (GET /reviews/restaurant/<int:restaurant_id>/)
Parameters:
restaurant_id: The ID of the restaurant.

Submit a Review: Submit a review for a restaurant (POST /reviews/restaurant/<int:restaurant_id>/add_review/)
Parameters:
rating: The rating given by the user.
comment: The review text.

Like a Restaurant: Like a restaurant (POST /reviews/restaurant/<int:restaurant_id>/like/)

Dislike a Restaurant: Dislike a restaurant (POST /reviews/restaurant/<int:restaurant_id>/dislike/)

Details from Views:

Functions in reviews/views.py handle the operations.
Authentication is required for submitting reviews and liking/disliking.

### Maps Module

Interaction with Web Service:

Fetching Location Data: The app retrieves restaurant location data to display on a map.

Displaying Restaurants on Map: Users view restaurants on an interactive map, possibly applying filters.

Endpoints Used:

Retrieve Map View with Restaurants: Retrieve map view with restaurants (GET /map/?search=<search_term>&search_by=<search_field>)
Parameters:
search (optional): Search term.
search_by (optional): Field to search by (name).

Details from Views:

RestaurantMapView in maps/views.py handles the requests.
Restaurants are filtered within Denpasar coordinates.


### Navigation Module

Interaction with Web Service:

Dynamic Content Loading: Requests data to display dynamic menu options, such as the user's name or notifications.

Session Management: Adjusts navigation options based on authentication status.

Endpoints Used:

User Customization: Retrieve user-specific data (GET /auth/customization/)

Check Authentication Status: Session-based; checked internally.

Details from Views:

The user_customization view provides personalized data.
Navigation adjusts based on request.user.is_authenticated and request.user.is_superuser.

### Admin Dashboard Module

Interaction with Web Service:

Managing Restaurants: Admin users add, edit, or delete restaurant data via HTTP requests.

Managing Users: Admins manage user accounts via API endpoints.

Endpoints Used:

Restaurant Management:

List All Restaurants (Admin View): List all restaurants with optional search functionality (GET /admin-dashboard/restaurants/?q=<query>)
Parameters:
q (optional): Search term for restaurant names.

Add a New Restaurant: Add a new restaurant to the database (POST /admin-dashboard/restaurants/add/)
Parameters:
Form data including required fields:
id, name, latitude, longitude, cuisines, website, phone, address, image_url
Optional fields as per the form.

Update Restaurant Details: Update an existing restaurant (POST /admin-dashboard/restaurants/update/<int:pk>/)
Parameters:
pk: Primary key (ID) of the restaurant.
Form data for fields to update.

Delete a Restaurant: Delete a restaurant (POST /admin-dashboard/restaurants/delete/<int:pk>/)
Parameters:
pk: Primary key of the restaurant.

Batch Delete Restaurants: Delete multiple restaurants at once (POST /admin-dashboard/delete/)
Parameters:
restaurant_ids: List of restaurant IDs to delete.

User Management:

List All Users: List all users with optional search functionality (GET /admin-dashboard/users/?q=<query>)
Parameters:
q (optional): Search term for usernames.

Add a New User: Add a new user account (POST /admin-dashboard/users/add/)
Parameters:
Form data from UserForm.

Update User Details: Update an existing user (POST /admin-dashboard/users/update/<int:pk>/)
Parameters:
pk: Primary key of the user.
Form data for fields to update.

Delete a User: Delete a user account (POST /admin-dashboard/users/delete/<int:pk>/)
Parameters:
pk: Primary key of the user.

Batch Delete Users: Delete multiple users at once (POST /admin-dashboard/users/delete/)
Parameters:
user_ids: List of user IDs to delete.

Details from Views:

Views in admin_dashboard/views.py handle operations.
Admin access is enforced via @login_required and @user_passes_test(lambda u: u.is_superuser) decorators.
