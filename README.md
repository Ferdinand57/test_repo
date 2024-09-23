Create a README.md that contains a link to the PWS application that has been deployed, as well as answers to the following
=

link to the PWS application that has been deployed: http://ferdinand-bonfilio-bonbonshop.pbp.cs.ui.ac.id/ 

Deployment credential:

```
Username: ferdinand.bonfilio

Password: nEIckZwXfCMNUS8s3j1NcZwPnX_LzTpc
```

You will need to use this command to deploy your code. If you have done this, in the future you will need to just use the third line only.

```
git remote add pws http://pbp.cs.ui.ac.id/ferdinand.bonfilio/bonbonshop

git branch -M master

git push pws master
```


Explain how did you implement the checklist step-by-step (apart from following the tutorial).
=



Implement the register, login, and logout functions so that the user can access the application freely.
=
Step 1: Implementing Function and Registration Forms

1. Activate virtual enviorement with env\Scripts\activate

2. Modify views.py in the main subdirectory to add the following
```
from django.contrib.auth.forms import UserCreationForm
from django.contrib import messages

def register(request):
    form = UserCreationForm()

    if request.method == "POST":
        form = UserCreationForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, 'Your account has been successfully created!')
            return redirect('main:login')
    context = {'form':form}
    return render(request, 'register.html', context)
```

3. Create a new HTML file named register.html in the main/templates directory
```
{% extends 'base.html' %} {% block meta %}
<title>Register</title>
{% endblock meta %} {% block content %}

<div class="login">
  <h1>Register</h1>

  <form method="POST">
    {% csrf_token %}
    <table>
      {{ form.as_table }}
      <tr>
        <td></td>
        <td><input type="submit" name="submit" value="Register" /></td>
      </tr>
    </table>
  </form>

  {% if messages %}
  <ul>
    {% for message in messages %}
    <li>{{ message }}</li>
    {% endfor %}
  </ul>
  {% endif %}
</div>

{% endblock content %}
```

4. Open urls.py in the main subdirectory and modify it to add the following:
```
from main.views import register

 urlpatterns = [
     ...
     path('register/', register, name='register'),
 ]
```

Step 2: Implementing a Login Function

1. Modify views.py in the main subdirectory to add the following
```
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from django.contrib.auth import authenticate, login

def login_user(request):
   if request.method == 'POST':
      form = AuthenticationForm(data=request.POST)

      if form.is_valid():
            user = form.get_user()
            login(request, user)
            return redirect('main:show_main')

   else:
      form = AuthenticationForm(request)
   context = {'form': form}
   return render(request, 'login.html', context)
```

2. Create a new HTML file named login.html in the main/templates directory
```
{% extends 'base.html' %}

{% block meta %}
<title>Login</title>
{% endblock meta %}

{% block content %}
<div class="login">
  <h1>Login</h1>

  <form method="POST" action="">
    {% csrf_token %}
    <table>
      {{ form.as_table }}
      <tr>
        <td></td>
        <td><input class="btn login_btn" type="submit" value="Login" /></td>
      </tr>
    </table>
  </form>

  {% if messages %}
  <ul>
    {% for message in messages %}
    <li>{{ message }}</li>
    {% endfor %}
  </ul>
  {% endif %} Don't have an account yet?
  <a href="{% url 'main:register' %}">Register Now</a>
</div>

{% endblock content %}
```

3. Open urls.py in the main subdirectory and modify it to add the following:
```
from main.views import login_user

urlpatterns = [
   ...
   path('login/', login_user, name='login'),
]
```

Step 3: Implementing a Logout Function

1. Modify views.py in the main subdirectory to add the following
```
from django.contrib.auth import logout

def logout_user(request):
    logout(request)
    return redirect('main:login')
```

2. Open main.html file in the main/templates directory and add the following code snippet after the hyperlink tag for "Add New Product Entry."
```
...
<a href="{% url 'main:logout' %}">
  <button>Logout</button>
</a>
...
```

3. Open urls.py in the main subdirectory and modify it to add the following:
```
from main.views import logout_user

urlpatterns = [
   ...
   path('logout/', logout_user, name='logout'),
]
```

Step 4: Restricting Access to the Main Page

1. Modify views.py in the main subdirectory to add the following
```
from django.contrib.auth.decorators import login_required
```

2. Add the code snippet @login_required(login_url='/login') above the show_main function so that the main page can only be accessed by authenticated (logged-in) users.
```
...
@login_required(login_url='/login')
def show_main(request):
...
```

Step 5: Using Data from Cookies

Firstly, log out if you are currently running your Django application.

1. Reopen views.py in the main subdirectory. Add the imports for HttpResponseRedirect, reverse, and datetime at the very top.

```
import datetime
from django.http import HttpResponseRedirect
from django.urls import reverse
```

2. In the login_user function, we will add the functionality to set a cookie named last_login to track when the user last logged in. Do this by replacing the code in the if form.is_valid() block with the following snippet.
```
...
if form.is_valid():
    user = form.get_user()
    login(request, user)
    response = HttpResponseRedirect(reverse("main:show_main"))
    response.set_cookie('last_login', str(datetime.datetime.now()))
    return response
...
```

3. In the show_main function, add the snippet 'last_login': request.COOKIES['last_login'] to the context variable. 
```
context = {
    'name': 'Pak Bepe',
    'class': 'PBP D',
    'npm': '2306123456',
    'product_entries': product_entries,
    'last_login': request.COOKIES.get('last_login', 'No login recorded'),
}
```

4. Modify the logout_user function to look like the following snippet.
```
def logout_user(request):
    logout(request)
    response = HttpResponseRedirect(reverse('main:login'))
    response.delete_cookie('last_login')
    return response
```

5. Open the main.html file and add the following snippet after the logout button to display the last login data.
```
...
<h5>Last login session: {{ last_login }}</h5>
...
```

6. Refresh the login page (or run your Django project using the command python manage.py runserver if you haven't already) and try logging in. Your last login data will appear on the main page.

```
Before proceeding to the next tutorial, create an account on your website.
```

make two user accounts with three dummy data each, using the model made in the application beforehand so that each data can be accessed by each account locally.
=

Bonbon Shop user:
```
User: Ferdinand1
Pass: bS"]FXPKcAf99_w

Apple juice
Good ol apple
1000

Cucumber juice
Cucumber is acidic btw
2000

Banana juice
Yellow liquid
3000
```
```
User: Ferdinand2
Pass: -#egKAf4_Y+Uwkj

Durian juice
Spiky and delicious
4000

Saraca juice
Spicy and more spicy
5000

Mustard juice
From yours truly
6000
```


Connect the models Product and User.
=

Lastly, we will link each ProductEntry object created to the user who made it so that an authorized user only sees the product entries they have created. Follow these steps:

1. Open models.py in the main subdirectory and add the following code below the line that imports the model:

```
...
from django.contrib.auth.models import User
...
```

2. In the previously created ProductEntry model, add the following code:
```
class ProductEntry(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    ...
```

3. Reopen views.py in the main subdirectory and modify the code in the create_product_entry function as follows:

```
def create_product_entry(request):
    form = ProductEntryForm(request.POST or None)

    if form.is_valid() and request.method == "POST":
        product_entry = form.save(commit=False)
        product_entry.user = request.user
        product_entry.save()
        return redirect('main:show_main')

    context = {'form': form}
    return render(request, "create_product_entry.html", context)
 ...
```

4. Change the value of product_entries and context in the function show_main as follows.

```
def show_main(request):
    product_entries = ProductEntry.objects.filter(user=request.user)

    context = {
         'name': request.user.username,
         ...
    }
...
```



5. Save all changes and run the model migration with python manage.py makemigrations.

6. You should encounter an error during the model migration. Select 1 to set a default value for the user field on all rows already created in the database.

7. Type 1 again to assign the user with ID 1 (which we created earlier) to the existing model

8. Run python manage.py migrate to apply the migration made in the previous step.

9. Lastly, we need to ensure our project is ready for a production environtment. To do that, add another import statement in settings.py in the mental_health_tracker subdirectory.

```
import os
```

10. Then, change the variable DEBUG in settings.py into this.

```
PRODUCTION = os.getenv("PRODUCTION", False)
DEBUG = not PRODUCTION
```

Display logged in user details such as username and apply cookies like last login to the application's main page.
=

We already did this before where we apply login:

step 5.3: we change the last_login to request cookies

3. In the show_main function, add the snippet 'last_login': request.COOKIES['last_login'] to the context variable. Here is an example of the updated code.
```
context = {
    'name': 'Pak Bepe',
    'class': 'PBP D',
    'npm': '2306123456',
    'product_entries': product_entries,
    'last_login': request.COOKIES.get('last_login', 'No login recorded'),
}
```


5.5: we add last login session on the main.html


5. Open the main.html file and add the following snippet after the logout button to display the last login data.
```
...
<h5>Last login session: {{ last_login }}</h5>
...
```

and when we models product to user we add the following on step 4 which display the user name used for the login as the name shown:

4. Change the value of product_entries and context in the function show_main as follows.

```
def show_main(request):
    product_entries = ProductEntry.objects.filter(user=request.user)

    context = {
         'name': request.user.username,
         ...
    }
...
```

What is the difference between HttpResponseRedirect() and redirect()?
=

Both HttpResponseRedirect() and redirect() are used in Django to redirect users from one URL to another, but they differ in terms of simplicity and flexibility.

HttpResponseRedirect() is a Django class that creates an HTTP response with a status code indicating a redirection (typically 302). It requires you to specify the exact URL to redirect to. You have to manually construct the full URL, which can be less convenient. For example: return HttpResponseRedirect('/login/')

The downside is if your URL patterns change or you have dynamic URLs, you need to update all instances where you've hard-coded the URLs, making maintenance more challenging.

redirect() is a shortcut function provided by Django to simplify redirection. It can accept various types of arguments:
- A view name
- A URL pattern name defined in your urls.py
- An absolute or relative URL
- An object (if the object defines a get_absolute_url() method)

Internally, redirect() uses HttpResponseRedirect() to perform the redirection but handles the URL resolution for you, for example: return redirect('login')

The upside of using redirect() is that you don't have to build the URL manually; you can simply refer to the name of the view or URL pattern, not only that if your URL patterns change, you only need to update the urls.py file, and the redirect() calls will continue to work without modification, and because it used names rather than hard-coded URLs makes your code cleaner and easier to maintain.

Summary: While HttpResponseRedirect() requires you to provide the exact URL and manage changes manually, redirect() offers a simpler and more flexible approach by resolving URLs internally, reducing the risk of errors and making your codebase easier to maintain.

Explain how the ProductEntry model is linked with User!
=

We linked the ProductEntry model with the User model to associate each product entry with the user who created it by doing the following:

1. Added a User Reference: In the ProductEntry model, we included a field that references the User model. This field acts like a link between a product entry and a user.

2. Assigned the Current User: When a user creates a new product entry, we set the user field of that entry to the currently logged-in user. This means the product entry now knows who created it.

3. Filtered Entries by User: In our views, when displaying product entries, we retrieve only the entries that belong to the logged-in user. This ensures that users see only their own entries.
    
What is the difference between authentication and authorization, and what happens when a user logs in? Explain how Django implements these two concepts.
=

Authentication is the process of verifying who a user is. When a user logs in by entering their username and password, the application checks these credentials to confirm the user's identity.

Authorization determines what an authenticated user is allowed to do. After a user is authenticated, authorization controls their access to certain pages or actions within the application based on their permissions.

When a user logs in:

1. Authentication: The application checks the provided credentials. If they match the records, the user is authenticated.

2. Session Creation: Upon successful authentication, the application creates a session for the user to keep them logged in across different pages.

3. Authorization: The application then uses authorization rules to determine what the user can access.

Django implements these concepts using its built-in authentication system:

1. For authentication, Django provides functions to handle login and logout processes, managing user sessions securely.

2. For authorization, Django uses decorators like @login_required to protect views, ensuring that only authenticated users can access certain parts of the application.

How does Django remember logged-in users? Explain other uses of cookies and whether all cookies are safe to use.
=

Django remembers logged-in users by creating a session for each user and storing a unique session ID in a cookie on their browser. This cookie is sent with every request the user makes, allowing Django to identify the user and maintain their logged-in state across different pages.

Other uses of cookies include:

1. Remembering user preferences: Cookies can store settings like language choices or display preferences so that the site appears the same way on subsequent visits.

2. Tracking user activity: They can help understand how users interact with the site, which pages they visit, and how often.

3. Keeping items in a shopping cart: For e-commerce sites, cookies can remember what items a user has added to their cart even if they navigate away from the page.


Not all cookies are inherently safe. While they are essential for many web functionalities, they can pose security risks if not handled properly:

Sensitive Data: Storing confidential information directly in cookies is risky because cookies are stored on the user's computer and can be accessed or modified.

Security Measures: It's important to use cookies securely by encrypting sensitive information, using secure flags to prevent unauthorized access, and setting appropriate expiration dates.


