Integration with the Web Service to Connect to the Web Application Created in the Midterm Project

Each module in the Denpasar Restaurant Finder application interacts with our Django-based web service to provide dynamic content and functionality. Below is an explanation of how each module interacts with the web service, incorporating details from our Django views, including parameters and HTTP methods.
Restaurants Module

Interaction with Web Service:

    Fetching Restaurant Data: The application sends HTTP GET requests to retrieve a list of restaurants. This includes details like restaurant names, locations, cuisines, price ranges, menus, photos, operating hours, and contact information.

    Filtering and Sorting: Users can apply filters or sorting options, which are sent as query parameters in the GET requests. The web service processes these parameters and returns the filtered and sorted list of restaurants.

Endpoints Used:

    Retrieve All Restaurants:
        Endpoint: GET /
        Description: Retrieves a paginated list of all restaurants.
        Parameters:
            page (optional): The page number for pagination.

    Retrieve Restaurants with Filters:
        Endpoint: GET /?search=<search_term>&search_by=<search_field>&cuisines=<cuisine1>&cuisines=<cuisine2>&...
        Description: Retrieves restaurants based on search terms and selected cuisines.
        Parameters:
            search (optional): The search term entered by the user.
            search_by (optional): Field to search by (name or cuisine). Default is name.
            cuisines (optional): List of cuisines to filter by (can be multiple).
            page (optional): The page number for pagination.

    Retrieve Restaurants via AJAX:
        Endpoint: GET /ajax/?search=<search_term>&search_by=<search_field>&cuisines=<cuisine1>&cuisines=<cuisine2>&...
        Description: Used for asynchronous requests to dynamically update restaurant listings without reloading the page.
        Parameters: Same as above.

Details from Views:

    The RestaurantListView class in restaurants/views.py handles the GET requests and processes query parameters for searching and filtering.
    The get_queryset method filters restaurants based on the provided search, search_by, and cuisines parameters.
    Pagination is handled with paginate_by = 9, meaning 9 restaurants per page.

Authentication Module

Interaction with Web Service:

    User Registration: New users can register by sending HTTP POST requests with their information. The web service creates new user accounts.

    User Login: Users can log in by sending their credentials via HTTP POST requests. The web service authenticates the user and establishes a session.

    User Logout: Users can log out, and the app notifies the web service to terminate the session.

    User Customization: Authenticated users can access and update their customization settings.

Endpoints Used:

    User Login:
        Endpoint: POST /auth/login/
        Description: Authenticates a user and starts a session.
        Parameters:
            username: The user's username.
            password: The user's password.

    User Logout:
        Endpoint: POST /auth/logout/
        Description: Logs out the user and ends the session.

    User Registration:
        Endpoint: POST /auth/register/
        Description: Registers a new user account.
        Parameters:
            username: Desired username.
            password1: Password.
            password2: Password confirmation.

    User Customization:
        Endpoint (Access Settings): GET /auth/customization/
        Endpoint (Update Settings): POST /auth/customization/
        Description: Allows users to access and update their customization settings.
        Parameters (POST):
            Depends on the customization options available.

Details from Views:

    The login_view, logout_view, and register_view functions in authentication/views.py handle the respective authentication processes.
    Registration uses CustomUserCreationForm, which includes validation for password length and confirmation.
    user_customization view allows authenticated users to access their reviews and other personalized data.

Reviews Module

Interaction with Web Service:

    Submitting Reviews: Authenticated users can submit reviews for restaurants by sending HTTP POST requests with review content, ratings, and the restaurant ID.

    Fetching Reviews: The app retrieves reviews for a specific restaurant by sending HTTP GET requests. The web service returns all reviews associated with that restaurant.

    Liking/Disliking Restaurants: Users can like or dislike a restaurant, and these actions are recorded via POST requests.

Endpoints Used:

    Get Restaurant Details and Reviews:
        Endpoint: GET /reviews/restaurant/<int:restaurant_id>/
        Description: Retrieves restaurant details along with associated reviews.
        Parameters:
            restaurant_id: The ID of the restaurant.

    Submit a Review:
        Endpoint: POST /reviews/restaurant/<int:restaurant_id>/add_review/
        Description: Submits a new review for the specified restaurant.
        Parameters:
            restaurant_id: The ID of the restaurant.
            rating: The rating given by the user.
            comment: The review text.

    Like a Restaurant:
        Endpoint: POST /reviews/restaurant/<int:restaurant_id>/like/
        Description: Records a 'like' action for the restaurant.
        Parameters:
            restaurant_id: The ID of the restaurant.

    Dislike a Restaurant:
        Endpoint: POST /reviews/restaurant/<int:restaurant_id>/dislike/
        Description: Records a 'dislike' action for the restaurant.
        Parameters:
            restaurant_id: The ID of the restaurant.

Details from Views:

    The add_review, restaurant_detail, like_restaurant, and dislike_restaurant functions in reviews/views.py handle the respective operations.
    Authentication may be required for submitting reviews and liking/disliking restaurants.

Maps Module

Interaction with Web Service:

    Fetching Location Data: The app retrieves restaurant location data (latitude and longitude) to display them on a map.

    Displaying Restaurants on Map: Users can view restaurants on an interactive map, possibly applying filters.

Endpoints Used:

    Retrieve Map View with Restaurants:
        Endpoint: GET /map/?search=<search_term>&search_by=<search_field>
        Description: Retrieves the map view with restaurant locations, optionally filtered by search criteria.
        Parameters:
            search (optional): Search term.
            search_by (optional): Field to search by (name).

Details from Views:

    The RestaurantMapView class in maps/views.py handles the GET requests and processes query parameters for searching.
    The get_context_data method prepares the restaurant data to be displayed on the map.
    Restaurants are filtered to those within Denpasar coordinates.

Admin Dashboard Module

Interaction with Web Service:

    Managing Restaurants: Admin users can add, edit, or delete restaurant data by sending HTTP requests.

    Managing Users: Admins can manage user accounts via API endpoints provided by the web service.

Endpoints Used:

    Restaurant Management:

        List All Restaurants (Admin View):
            Endpoint: GET /admin-dashboard/restaurants/?q=<query>
            Description: Lists all restaurants with optional search functionality.
            Parameters:
                q (optional): Search term for restaurant names.

        Add a New Restaurant:
            Endpoint: POST /admin-dashboard/restaurants/add/
            Description: Adds a new restaurant to the database.
            Parameters:
                Form data from RestaurantForm, including required fields:
                    id
                    name
                    latitude
                    longitude
                    cuisines
                    website
                    phone
                    address
                    image_url
                Optional fields as per the form.

        Update Restaurant Details:
            Endpoint: POST /admin-dashboard/restaurants/update/<int:pk>/
            Description: Updates details of an existing restaurant.
            Parameters:
                pk: Primary key (ID) of the restaurant.
                Form data from RestaurantForm.

        Delete a Restaurant:
            Endpoint: POST /admin-dashboard/restaurants/delete/<int:pk>/
            Description: Deletes a restaurant from the database.
            Parameters:
                pk: Primary key (ID) of the restaurant.

        Batch Delete Restaurants:
            Endpoint: POST /admin-dashboard/delete/
            Description: Deletes multiple restaurants at once.
            Parameters:
                restaurant_ids: List of restaurant IDs to delete.

    User Management:

        List All Users:
            Endpoint: GET /admin-dashboard/users/?q=<query>
            Description: Lists all users with optional search functionality.
            Parameters:
                q (optional): Search term for usernames.

        Add a New User:
            Endpoint: POST /admin-dashboard/users/add/
            Description: Adds a new user account.
            Parameters:
                Form data from UserForm.

        Update User Details:
            Endpoint: POST /admin-dashboard/users/update/<int:pk>/
            Description: Updates details of an existing user.
            Parameters:
                pk: Primary key (ID) of the user.
                Form data from UserForm.

        Delete a User:
            Endpoint: POST /admin-dashboard/users/delete/<int:pk>/
            Description: Deletes a user account.
            Parameters:
                pk: Primary key (ID) of the user.

        Batch Delete Users:
            Endpoint: POST /admin-dashboard/users/delete/
            Description: Deletes multiple users at once.
            Parameters:
                user_ids: List of user IDs to delete.

Details from Views:

    All admin views are protected by @login_required and @user_passes_test(lambda u: u.is_superuser), ensuring only superuser (admin) access.
    The forms RestaurantForm and UserForm are used to handle input data.
    The admin_dashboard_restaurant_* and admin_dashboard_user_* functions in admin_dashboard/views.py handle the respective operations.

Navigation Module

Interaction with Web Service:

    Dynamic Content Loading: The navigation module may request data to display dynamic menu options, such as the user's name or notifications.

    Session Management: Utilizes authentication status to adjust available navigation options (e.g., showing admin options only to admin users).

Endpoints Used:

    User Customization:
        Endpoint: GET /auth/customization/
        Description: Retrieves user-specific data to personalize the navigation experience.
        Parameters: None.

    Check Authentication Status:
        Endpoint: Session-based; checked internally.
        Description: Determines if a user is logged in and their role (Guest, Customer, Admin).

Details from Views:

    The user_customization view provides data such as the user's reviews and preferred restaurants.
    Navigation options are adjusted based on request.user.is_authenticated and request.user.is_superuser.
