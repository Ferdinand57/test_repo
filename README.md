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

Explain how you implemented the checklist above step-by-step (not just following the tutorial).
=

Create a form input to add a model object to the previous app.
=

Creating the Form Structure:

File: Created a new file forms.py in the main app directory.

```
from django.forms import ModelForm
from main.models import ProductEntry

class ProductEntryForm(ModelForm):
    class Meta:
        model = ProductEntry
        fields = ["name", "description", "price"]
```

Handling Form Submission:

File: Updated views.py in the main app.

```
from django.shortcuts import render, redirect
from main.forms import ProductEntryForm
from main.models import ProductEntry

def create_product_entry(request):
    form = ProductEntryForm(request.POST or None)

    if form.is_valid() and request.method == "POST":
        form.save()
        return redirect('main:show_main')

    context = {'form': form}
    return render(request, "create_product_entry.html", context)
```

Updating URL Routing:

File: Modified urls.py in the main app.

```
from main.views import show_main, create_product_entry

urlpatterns = [
    path('', show_main, name='show_main'),
    path('create-product-entry', create_product_entry, name='create_product_entry'),
```

Creating the Form Template:

File: Created create_mood_entry.html in main/templates.

```
{% extends 'base.html' %} 
{% block content %}
<h1>Add New Product Entry</h1>

<form method="POST">
  {% csrf_token %}
  <table>
    {{ form.as_table }}
    <tr>
      <td></td>
      <td>
        <input type="submit" value="Add Product Entry" />
      </td>
    </tr>
  </table>
</form>

{% endblock %}
```

Add 4 views to view the added objects in XML, JSON, XML by ID, and JSON by ID formats.
=

Importing Necessary Modules:

File: At the top of views.py.

```
from django.http import HttpResponse
from django.core import serializers
```

Creating the Views:

View for XML Format:

```
def show_xml(request):
    data = MoodEntry.objects.all()
    return HttpResponse(serializers.serialize("xml", data), content_type="application/xml")
```

View for JSON Format:

```
def show_json(request):
    data = MoodEntry.objects.all()
    return HttpResponse(serializers.serialize("json", data), content_type="application/json")
```

View for XML by ID:

```
def show_xml_by_id(request, id):
    data = MoodEntry.objects.filter(pk=id)
    return HttpResponse(serializers.serialize("xml", data), content_type="application/xml")
```

View for JSON by ID:

```
def show_json_by_id(request, id):
    data = MoodEntry.objects.filter(pk=id)
    return HttpResponse(serializers.serialize("json", data), content_type="applicati
```


Create URL routing for each of the views added in point 2.
=

To make these views accessible via URLs, I updated the urls.py file:

```
from main.views import show_main, create_product_entry, show_xml, show_json, show_xml_by_id, show_json_by_id
```

Adding URL Patterns:

```
urlpatterns = [
    path('', show_main, name='show_main'),
    path('create-product-entry', create_product_entry, name='create_product_entry'),
    path('xml/', show_xml, name='show_xml'),
    path('json/', show_json, name='show_json'),
    path('xml/<str:id>/', show_xml_by_id, name='show_xml_by_id'),
    path('json/<str:id>/', show_json_by_id, name='show_json_by_id'),
]
```


Answer the following questions in README.md in the root folder.
=

Explain why we need data delivery in implementing a platform.
=

Data delivery is very important in platform based development because it enables the exchange of information between the user interface (frontend) and the server (backend). Without data delivery mechanisms, users wouldn't be able to send input to the platform, and the platform wouldn't be able provide responses or updates back to the user. In essence, data delivery is what makes a platform interactive and functional by allowing data to flow smoothly between different parts of the system.

In your opinion, which is better, XML or JSON? Why is JSON more popular than XML?
=

In my opinion, JSON (JavaScript Object Notation) is generally better than XML (eXtensible Markup Language) for most web development tasks due to its simplicity and efficiency. JSON uses a straightforward key value pair structure, making it easier to read and write. It also supports native data types like strings, numbers, arrays, and booleans, which fit well with programming languages. In contrast, XML is more complicated and uses many extra tags, which can make the files larger and harder to handle. XML treats all data as text, so you often need to do extra work to convert it into usable formats in your programs.

While XML is still used in cases that require complex data structures or document formatting, its complexity and larger file sizes can slow down applications and make development more challenging. JSON's advantages in simplicity, smaller file sizes, and faster processing have made it the go to format for data exchange in web development, offering a better performance and an easier experience for developers.

Explain the functional usage of is_valid() method in Django forms. Also explain why we need the method in forms.
=

The is_valid() method in Django forms is used to validate data submitted by a user. When invoked, it checks each form field against the validation criteria we've defined, such as required fields, data types, and custom validation rules. If all fields pass these checks, is_valid() returns True, and the cleaned data go to further processing like saving to a database.

We need the is_valid() method to ensure that only accurate and appropriate data is processed by the application. It helps maintain data integrity and enhances security by preventing invalid or malicious data from causing errors or vulnerabilities, it also enables the application to provide meaningful feedback to users, allowing them to correct any input errors, which improves the overall user experience.

Why do we need csrf_token when creating a form in Django? What could happen if we did not use csrf_token on a Django form? How could this be leveraged by an attacker?
=

The csrf_token is essential in Django forms to protect against Cross-Site Request Forgery (CSRF) attacks. It works by using a CSRF cookie that contains a random secret value, which other sites will not have access to. This token is embedded in forms as a hidden field named 'csrfmiddlewaretoken'. When the form is submitted, Django verifies this token to ensure the request is legitimate and originates from our website.

Without the csrf_token, our application becomes vulnerable to CSRF attacks where attackers can trick authenticated users into unknowingly submitting forms. This type of attack occurs when a malicious website contains a link, a form button, or some JavaScript intended to perform some action on our website using the credentials of a logged-in user. Including the csrf_token ensures that only genuine requests are processed, thereby safeguarding both our users and our application from such malicious activities.

source: https://docs.djangoproject.com/en/5.1/ref/csrf/


Access the four URLs in point 2 using Postman, take screenshots of the results in Postman, and add them to README.md.
=

