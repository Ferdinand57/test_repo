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
2. Open main.html file in the main/templates directory and add the following code snippet after the hyperlink tag for "Add New Mood Entry."
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

3. In the show_main function, add the snippet 'last_login': request.COOKIES['last_login'] to the context variable. Here is an example of the updated code.
```
context = {
    'name': 'Pak Bepe',
    'class': 'PBP D',
    'npm': '2306123456',
    'mood_entries': mood_entries,
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
Lastly, we will link each MoodEntry object created to the user who made it so that an authorized user only sees the mood entries they have created. Follow these steps:

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

Display logged in user details such as username and apply cookies like last login to the application's main page.
=




What is the difference between HttpResponseRedirect() and redirect()?
=



Explain how the MoodEntry model is linked with User!
=



What is the difference between authentication and authorization, and what happens when a user logs in? Explain how Django implements these two concepts.
=



How does Django remember logged-in users? Explain other uses of cookies and whether all cookies are safe to use.
=



