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


The checklist for this assignment is as follows, Explain how you implemented the checklist above step-by-step (not just following the tutorial)!:
=
Implement functions to delete and edit products.
=
1. Create the Edit Product Function:

In views.py in the main subdirectory, I added a new function named edit_product that takes request and id as parameters.
```
def edit_product(request, id):
    # Get product entry based on id
    product = ProductEntry.objects.get(pk = id)

    # Set product entry as an instance of the form
    form = ProductEntryForm(request.POST or None, instance=product)

    if form.is_valid() and request.method == "POST":
        # Save form and return to home page
        form.save()
        return HttpResponseRedirect(reverse('main:show_main'))

    context = {'form': form}
    return render(request, "edit_product.html", context)
```

Imports Added to views.py:
```
from django.shortcuts import .., reverse
from django.http import .., HttpResponseRedirect
```

2. Create the Edit Product Template:

I created a new HTML file named edit_product.html in the main/templates subdirectory and filled it with the following content:
```
{% extends 'base.html' %}

{% load static %}

{% block content %}

<h1>Edit Product</h1>

<form method="POST">
    {% csrf_token %}
    <table>
        {{ form.as_table }}
        <tr>
            <td></td>
            <td>
                <input type="submit" value="Edit Product"/>
            </td>
        </tr>
    </table>
</form>

{% endblock %}
```

3. Update urls.py for Edit Product:

In urls.py in the main directory, I imported the edit_product function:
```
from main.views import edit_product
```

Then, I added a URL path to urlpatterns:
```
path('edit-product/<uuid:id>', edit_product, name='edit_product'),
```

Note: Adjust the <uuid:id> to <int:id> if the id in ProductEntry is an integer.

4. Add an Edit Button in the Product List Template:

In main.html in the main/templates subdirectory, I added the following code to display an edit button for each product:
```
<tr>
    ...
    <td>
        <a href="{% url 'main:edit_product' product_entry.pk %}">
            <button>
                Edit
            </button>
        </a>
    </td>
</tr>
```

5. Create the Delete Product Function:

In views.py, I added a new function named delete_product:

```
def delete_product(request, id):
    # Get product based on id
    product = ProductEntry.objects.get(pk = id)
    # Delete product
    product.delete()
    # Return to home page
    return HttpResponseRedirect(reverse('main:show_main'))
```
6. Update urls.py for Delete Product:

In urls.py, I imported the delete_product function:
```
from main.views import delete_product
```

Then, I added a URL path:
```
path('delete/<uuid:id>', delete_product, name='delete_product'),
```

Again, adjust <uuid:id> if necessary.

7. Add a Delete Button in the Product List Template:

In main.html, I modified the code to include a delete button:
```
<tr>
    ...
    <td>
        <a href="{% url 'main:edit_product' product_entry.pk %}">
            <button>
                Edit
            </button>
        </a>
    </td>
    <td>
        <a href="{% url 'main:delete_product' product_entry.pk %}">
            <button>
                Delete
            </button>
        </a>
    </td>
</tr>
```

Customize the design of the HTML templates that have been created in previous assignments using CSS or a CSS framework (such as Bootstrap, Tailwind, Bulma) with the following conditions:
=
Customize the login, register, and add product pages to be as attractive as possible.
=

1. Link Tailwind CSS in base.html:

In base.html, I added the Tailwind CSS CDN link:
```
  <head>
    {% block meta %}
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
    {% endblock meta %}
    <script src="https://cdn.tailwindcss.com">
    </script>
  </head>
```

2. Create and Link global.css:

- Configuring Static Files in the Application

In settings.py, add the WhiteNoise middleware.
```
...
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'whitenoise.middleware.WhiteNoiseMiddleware', # Add it directly under SecurityMiddleware
    ...
]
...
```

By adding the WhiteNoise middleware to settings.py, Django can automatically manage static files in production mode (DEBUG=False) without needing complex configuration. This is useful so that static files can be accessed in your deployment because by default, if DEBUG=False then Django will not provide access to static files.

- In settings.py, ensure that the STATIC_ROOT, STATICFILES_DIRS, and STATIC_URL variables are configured like this (if they don't exist, you can just add them):

```
...
STATIC_URL = '/static/'
if DEBUG:
    STATICFILES_DIRS = [
        BASE_DIR / 'static' # refers to /static root project in development mode
    ]
else:
    STATIC_ROOT = BASE_DIR / 'static' # refers to /static root project in production mode
...
```

Create a global.css file in static/css and linked it in base.html:

```
{% load static %}
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    {% block meta %} {% endblock meta %}
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="{% static 'css/global.css' %}"/> 
  </head>
  <body>
    {% block content %} {% endblock content %}
  </body>
</html>
```

3. Add Custom Styles in global.css:
```
.form-style form input, form textarea, form select {
    width: 100%;
    padding: 0.5rem;
    border: 2px solid #bcbcbc;
    border-radius: 0.375rem;
}
.form-style form input:focus, form textarea:focus, form select:focus {
    outline: none;
    border-color: #674ea7;
    box-shadow: 0 0 0 3px #674ea7;
}
@keyframes shine {
    0% { background-position: -200% 0; }
    100% { background-position: 200% 0; }
}
.animate-shine {
    background: linear-gradient(120deg, rgba(255, 255, 255, 0.3), rgba(255, 255, 255, 0.1) 50%, rgba(255, 255, 255, 0.3));
    background-size: 200% 100%;
    animation: shine 3s infinite;
}
```

4. Customize the Login Page (login.html):
```
{% extends 'base.html' %}

{% block meta %}
<title>Login</title>
{% endblock meta %}

{% block content %}
<div class="min-h-screen flex items-center justify-center w-screen bg-gray-100 py-12 px-4 sm:px-6 lg:px-8">
  <div class="max-w-md w-full space-y-8">
    <div>
      <h2 class="mt-6 text-center text-black text-3xl font-extrabold text-gray-900">
        Login to your account
      </h2>
    </div>
    <form class="mt-8 space-y-6" method="POST" action="">
      {% csrf_token %}
      <input type="hidden" name="remember" value="true">
      <div class="rounded-md shadow-sm -space-y-px">
        <div>
          <label for="username" class="sr-only">Username</label>
          <input id="username" name="username" type="text" required class="appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-t-md focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 focus:z-10 sm:text-sm" placeholder="Username">
        </div>
        <div>
          <label for="password" class="sr-only">Password</label>
          <input id="password" name="password" type="password" required class="appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-b-md focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 focus:z-10 sm:text-sm" placeholder="Password">
        </div>
      </div>

      <div>
        <button type="submit" class="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
          Sign in
        </button>
      </div>
    </form>

    {% if messages %}
    <div class="mt-4">
      {% for message in messages %}
      {% if message.tags == "success" %}
            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative" role="alert">
                <span class="block sm:inline">{{ message }}</span>
            </div>
        {% elif message.tags == "error" %}
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
                <span class="block sm:inline">{{ message }}</span>
            </div>
        {% else %}
            <div class="bg-blue-100 border border-blue-400 text-blue-700 px-4 py-3 rounded relative" role="alert">
                <span class="block sm:inline">{{ message }}</span>
            </div>
        {% endif %}
      {% endfor %}
    </div>
    {% endif %}

    <div class="text-center mt-4">
      <p class="text-sm text-black">
        Don't have an account yet?
        <a href="{% url 'main:register' %}" class="font-medium text-indigo-200 hover:text-indigo-300">
          Register Now
        </a>
      </p>
    </div>
  </div>
</div>
{% endblock content %}
```

5. Customize the Register Page (register.html):
```
{% extends 'base.html' %}

{% block meta %}
<title>Register</title>
{% endblock meta %}

{% block content %}
<div class="min-h-screen flex items-center justify-center bg-gray-100 py-12 px-4 sm:px-6 lg:px-8">
  <div class="max-w-md w-full space-y-8 form-style">
    <div>
      <h2 class="mt-6 text-center text-3xl font-extrabold text-black">
        Create your account
      </h2>
    </div>
    <form class="mt-8 space-y-6" method="POST">
      {% csrf_token %}
      <input type="hidden" name="remember" value="true">
      <div class="rounded-md shadow-sm -space-y-px">
        {% for field in form %}
          <div class="{% if not forloop.first %}mt-4{% endif %}">
            <label for="{{ field.id_for_label }}" class="mb-2 font-semibold text-black">
              {{ field.label }}
            </label>
            <div class="relative">
              {{ field }}
              <div class="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                {% if field.errors %}
                  <svg class="h-5 w-5 text-red-500" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd" />
                  </svg>
                {% endif %}
              </div>
            </div>
            {% if field.errors %}
              {% for error in field.errors %}
                <p class="mt-1 text-sm text-red-600">{{ error }}</p>
              {% endfor %}
            {% endif %}
          </div>
        {% endfor %}
      </div>

      <div>
        <button type="submit" class="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
          Register
        </button>
      </div>
    </form>

    {% if messages %}
    <div class="mt-4">
      {% for message in messages %}
      <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
        <span class="block sm:inline">{{ message }}</span>
      </div>
      {% endfor %}
    </div>
    {% endif %}

    <div class="text-center mt-4">
      <p class="text-sm text-black">
        Already have an account?
        <a href="{% url 'main:login' %}" class="font-medium text-indigo-200 hover:text-indigo-300">
          Login here
        </a>
      </p>
    </div>
  </div>
</div>
{% endblock content %}
```

6. Customize the Add Product Page (create_product_entry.html):
```
{% extends 'base.html' %}
{% load static %}
{% block meta %}
<title>Create Product</title>
{% endblock meta %}

{% block content %}
{% include 'navbar.html' %}

<div class="flex flex-col min-h-screen bg-gray-100">
  <div class="container mx-auto px-4 py-8 mt-16 max-w-xl">
    <h1 class="text-3xl font-bold text-center mb-8 text-black">Create Product Entry</h1>
  
    <div class="bg-white shadow-md rounded-lg p-6 form-style">
      <form method="POST" class="space-y-6">
        {% csrf_token %}
        {% for field in form %}
          <div class="flex flex-col">
            <label for="{{ field.id_for_label }}" class="mb-2 font-semibold text-gray-700">
              {{ field.label }}
            </label>
            <div class="w-full">
              {{ field }}
            </div>
            {% if field.help_text %}
              <p class="mt-1 text-sm text-gray-500">{{ field.help_text }}</p>
            {% endif %}
            {% for error in field.errors %}
              <p class="mt-1 text-sm text-red-600">{{ error }}</p>
            {% endfor %}
          </div>
        {% endfor %}
        <div class="flex justify-center mt-6">
          <button type="submit" class="bg-indigo-600 text-white font-semibold px-6 py-3 rounded-lg hover:bg-indigo-700 transition duration-300 ease-in-out w-full">
            Create Product Entry
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

{% endblock %}
```

Customize the product list page to be more attractive and responsive. Then, consider the following conditions:
=

If there are no products saved in the application, the product list page will display an image and a message that no products are registered.
=


If there are products saved, the product list page will display details of each product using cards (must not be exactly the same as the design in the Tutorial!).
=


For each product card, create two buttons to edit and delete the product on that card!
=


Create a navigation bar (navbar) for the features in the application that is responsive to different device sizes, especially mobile and desktop.
=

==============================================================================================================================================================================================================================================
=
Answer the following questions in README.md in the root folder (please modify the README.md you have created before; add subheadings for each assignment).
=
If there are multiple CSS selectors for an HTML element, explain the priority order of these CSS selectors!
=
When we apply styles to an HTML element using CSS, sometimes multiple styles might conflict because they target the same element. In such cases, the browser follows a specific priority order to decide which style to apply. The priority order from highest to lowest is:

- Inline Styles: These are styles written directly in the HTML element using the style attribute. Inline styles have the highest priority because they are applied directly to the element. For example:
    
```
html

<p style="color: blue;">This text is blue.</p>
```

- External and Internal Style Sheets: These styles are defined either in a separate CSS file linked to the HTML (external) or within a <style> tag in the HTML document itself (internal). Styles from external and internal style sheets have a lower priority than inline styles but will override browser defaults. For example:

```
html

<!-- Internal Style Sheet -->
<style>
  p {
    color: red;
  }
</style>

<!-- External Style Sheet -->
<link rel="stylesheet" href="styles.css">
```

- Browser Default: If no styles are provided, the browser applies its default styles to elements. These are the lowest in priority and are only used when no other styles are specified.

In summary, if an element has styles defined at multiple levels, the browser will apply the style with the highest priority. Inline styles override external and internal style sheets, which in turn override the browser's default styles.

Why does responsive design become an important concept in web application development? Give examples of applications that have and have not implemented responsive design!
=

Responsive design is essential in web development because it ensures that websites are accessible and user-friendly across a variety of devices with different screen sizes and capabilities. With the increasing use of smartphones and tablets, people access websites on devices other than desktop computers. Responsive design allows a website to adapt its layout and content to fit the screen of the device being used, providing an optimal viewing experience

For example:

- Applications with Responsive Design: Many modern websites and web applications implement responsive design. When we visit a news website on our phone, the content rearranges itself to fit the smaller screen, images resize, and menus become touch-friendly. This makes it easy to read articles and navigate the site on any device

- Applications without Responsive Design: Older websites or those that haven't been updated may not implement responsive design. When we access such a site on a mobile device, we might see tiny text, oversized images, or content that doesn't fit the screen, requiring us to zoom in and scroll horizontally. This can make the site difficult to use and discourage visitors

Responsive design improves user experience by ensuring that content is presented in a clear and accessible manner, regardless of the device used. It also helps websites reach a wider audience and keeps users engaged

Explain the differences between margin, border, and padding, and how to implement these three things!
=

In web design, understanding the box model is crucial. The box model describes how elements are structured and how spacing works around them. It consists of:

- Content: The actual text, images, or other media inside the element.
- Padding: The space between the content and the element's border. Padding adds internal spacing within the element.
- Border: A line or edge that surrounds the padding and content. It defines the outline of the element.
- Margin: The space outside the border that separates the element from other elements. Margins add external spacing between elements.

The difference are the following:

- Margin:

Purpose: Creates space outside the element's border, pushing other elements away.

Usage: Use margins to control the spacing between elements on a page.

Implementation:
```
css

.example {
  margin: 20px; /* Adds 20 pixels of space around the element */
}
```



- Border:

Purpose: Defines the edge of the element and can be styled to enhance visual appearance. 

Usage: Use borders to outline elements, separate sections, or add visual emphasis.

Implementation:
```
css

.example {
  border: 2px solid black; /* Adds a solid black border 2 pixels thick */
}
```

- Padding:

Purpose: Adds space inside the element between the content and the border.

Usage: Use padding to ensure content isn't touching the borders and to improve readability.

Implementation:
```
css

.example {
  padding: 10px; /* Adds 10 pixels of space inside the element */
}
```

Explain the concepts of flex box and grid layout along with their uses!
=

Flexbox and grid are modern CSS layout systems that help us design responsive and flexible web layouts more easily

Flexbox (Flexible Box Layout):
- Concept: Flexbox is designed for one-dimensional layouts, meaning it works in either a row or a column
- Usage: It allows us to align and distribute space among items in a container, even when their size is unknown or dynamic
- Example: If we have a navigation menu and we want the items to spread out evenly across the horizontal space, flexbox makes this simple

Grid Layout:
- Concept: Grid layout is intended for two-dimensional layouts, handling both rows and columns simultaneously
- Usage: It enables us to create complex and responsive grid structures, making it easier to design page layouts without using floats or positioning
- Example: When designing a photo gallery where images need to be aligned both horizontally and vertically, grid layout provides a straightforward solution
