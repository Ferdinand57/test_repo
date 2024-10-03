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

Explain how you implemented the checklist above step-by-step (not just following the tutorial)!
=

Modify the previously created assignment 5 to use AJAX.
=

To make the login process easier for our users, provide a conditional to the login_user view in our views.py.
```
...
if form.is_valid():
    user = form.get_user()
    login(request, user)
    response = HttpResponseRedirect(reverse("main:show_main"))
    response.set_cookie('last_login', str(datetime.datetime.now()))
    return response
else:
    messages.error(request, "Invalid username or password. Please try again.")
...
```

AJAX GET
=

- Modify the codes in data cards to able to use AJAX GET.

First, we remove the direct fetching of product_entries in the views.py file, as we will now fetch this data asynchronously.
```
# In views.py, remove these lines:
product_entries = ProductEntry.objects.filter(user=request.user)

# Also remove 'product_entries' from the context:
'product_entries': product_entries,
```

Next, we adjust the data retrieval in the show_json and show_xml functions to ensure we're only fetching data for the logged-in user.
```
# In views.py, modify the data retrieval:
data = ProductEntry.objects.filter(user=request.user)
```

In the main.html template, we remove the conditional block that directly renders product_entries, as we'll now render them via JavaScript.

```
<!-- Remove this block from main.html -->
{% if not product_entries %}
    <div class="flex flex-col items-center justify-center min-h-[24rem] p-6">
        <img src="{% static 'image/sedih-banget.png' %}" alt="Sad face" class="w-32 h-32 mb-4"/>
        <p class="text-center text-gray-600 mt-4">No product data on the mental health tracker yet</p>
    </div>
{% else %}
    <div class="columns-1 sm:columns-2 lg:columns-3 gap-6 space-y-6 w-full">
        {% for product_entry in product_entries %}
            {% include 'card_product.html' with product_entry=product_entry %}
        {% endfor %}
    </div>
{% endif %}
```

After removing the above code, we add a new div element that will serve as a container for our product entries.

```
<!-- Add this to main.html -->
<div id="product_entry_cards"></div>
```

- Retrieve data using AJAX GET. Make sure that the datas retrieved are only the datas belonging to the logged in user.

We create a JavaScript function getProductEntries to fetch the product data asynchronously.

```
<!-- In main.html, before the end of the content block -->
<script>
  async function getProductEntries() {
      return fetch("{% url 'main:show_json' %}").then((res) => res.json());
  }
</script>
```

Next, we create a function refreshProductEntries to update the product entries on the page without reloading.
```
<script>
  async function refreshProductEntries() {
    document.getElementById("product_entry_cards").innerHTML = "";
    document.getElementById("product_entry_cards").className = "";
    const productEntries = await getProductEntries();
    let htmlString = "";
    let classNameString = "";

    if (productEntries.length === 0) {
        classNameString = "flex flex-col items-center justify-center min-h-[24rem] p-6";
        htmlString = `
            <div class="flex flex-col items-center justify-center min-h-[24rem] p-6">
                <img src="{% static 'image/sedih-banget.png' %}" alt="Sad face" class="w-32 h-32 mb-4"/>
                <p class="text-center text-gray-600 mt-4">No product data on the mental health tracker yet.</p>
            </div>
        `;
    } else {
        classNameString = "columns-1 sm:columns-2 lg:columns-3 gap-6 space-y-6 w-full";
        productEntries.forEach((item) => {
            htmlString += `
            <div class="relative break-inside-avoid">
                <div class="absolute top-2 z-10 left-1/2 -translate-x-1/2 flex items-center -space-x-2">
                    <div class="w-[3rem] h-8 bg-gray-200 rounded-md opacity-80 -rotate-90"></div>
                    <div class="w-[3rem] h-8 bg-gray-200 rounded-md opacity-80 -rotate-90"></div>
                </div>
                <div class="relative top-5 bg-indigo-100 shadow-md rounded-lg mb-6 break-inside-avoid flex flex-col border-2 border-indigo-300 transform rotate-1 hover:rotate-0 transition-transform duration-300">
                    <div class="bg-indigo-200 text-gray-800 p-4 rounded-t-lg border-b-2 border-indigo-300">
                        <h3 class="font-bold text-xl mb-2">${item.fields.name}</h3>
                        <p class="text-gray-600">${item.fields.time}</p>
                    </div>
                    <div class="p-4">
                        <p class="font-semibold text-lg mb-2">Description</p>
                        <p class="text-gray-700 mb-2">
                            <span class="bg-[linear-gradient(to_bottom,transparent_0%,transparent_calc(100%_-_1px),#CDC1FF_calc(100%_-_1px))] bg-[length:100%_1.5rem] pb-1">${item.fields.description}</span>
                        </p>
                        <div class="mt-4">
                            <p class="text-gray-700 font-semibold mb-2">Price</p>
                            <div class="relative pt-1">
                                <div class="flex mb-2 items-center justify-between">
                                    <div>
                                        <span class="text-xs font-semibold inline-block py-1 px-2 uppercase rounded-full text-indigo-600 bg-indigo-200">
                                            ${item.fields.price > 10 ? '10+' : item.fields.price}
                                        </span>
                                    </div>
                                </div>
                                <div class="overflow-hidden h-2 mb-4 text-xs flex rounded bg-indigo-200">
                                    <div style="width: ${item.fields.price > 10 ? 100 : item.fields.price * 10}%;" class="shadow-none flex flex-col text-center whitespace-nowrap text-white justify-center bg-indigo-500"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="absolute top-0 -right-4 flex space-x-1">
                    <a href="/edit-product/${item.pk}" class="bg-yellow-500 hover:bg-yellow-600 text-white rounded-full p-2 transition duration-300 shadow-md">
                        <!-- Edit icon -->
                    </a>
                    <a href="/delete/${item.pk}" class="bg-red-500 hover:bg-red-600 text-white rounded-full p-2 transition duration-300 shadow-md">
                        <!-- Delete icon -->
                    </a>
                </div>
            </div>
            `;
        });
    }
    document.getElementById("product_entry_cards").className = classNameString;
    document.getElementById("product_entry_cards").innerHTML = htmlString;
  }
  refreshProductEntries();
</script>
```

By adjusting our views and templates, we ensure that only the logged-in user's data is retrieved and displayed.


AJAX POST
=

- Create a button that opens a modal with a form for adding a product entry.

We add a modal form to our application, which is triggered by a button click.
```
<!-- Add this code below the div with id 'product_entry_cards' -->
<div id="crudModal" tabindex="-1" aria-hidden="true" class="hidden fixed inset-0 z-50 w-full flex items-center justify-center bg-gray-800 bg-opacity-50 overflow-x-hidden overflow-y-auto transition-opacity duration-300 ease-out">
  <div id="crudModalContent" class="relative bg-white rounded-lg shadow-lg w-5/6 sm:w-3/4 md:w-1/2 lg:w-1/3 mx-4 sm:mx-0 transform scale-95 opacity-0 transition-transform transition-opacity duration-300 ease-out">
    <!-- Modal header -->
    <div class="flex items-center justify-between p-4 border-b rounded-t">
      <h3 class="text-xl font-semibold text-gray-900">
        Add New Product Entry
      </h3>
      <button type="button" class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center" id="closeModalBtn">
        <!-- Close icon -->
      </button>
    </div>
    <!-- Modal body -->
    <div class="px-6 py-4 space-y-6 form-style">
      <form id="productEntryForm">
        <div class="mb-4">
          <label for="name" class="block text-sm font-medium text-gray-700">Product</label>
          <input type="text" id="name" name="name" class="mt-1 block w-full border border-gray-300 rounded-md p-2 hover:border-indigo-700" placeholder="Enter your product" required>
        </div>
        <div class="mb-4">
          <label for="description" class="block text-sm font-medium text-gray-700">Description</label>
          <textarea id="description" name="description" rows="3" class="mt-1 block w-full h-52 resize-none border border-gray-300 rounded-md p-2 hover:border-indigo-700" placeholder="Describe your product" required></textarea>
        </div>
        <div class="mb-4">
          <label for="price" class="block text-sm font-medium text-gray-700">Price</label>
          <input type="number" id="price" name="price" min="1" class="mt-1 block w-full border border-gray-300 rounded-md p-2 hover:border-indigo-700" required>
        </div>
      </form>
    </div>
    <!-- Modal footer -->
    <div class="flex flex-col space-y-2 md:flex-row md:space-y-0 md:space-x-2 p-6 border-t border-gray-200 rounded-b justify-center md:justify-end">
      <button type="button" class="bg-gray-500 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded-lg" id="cancelButton">Cancel</button>
      <button type="submit" id="submitProductEntry" form="productEntryForm" class="bg-indigo-700 hover:bg-indigo-600 text-white font-bold py-2 px-4 rounded-lg">Save</button>
    </div>
  </div>
</div>
```

We include JavaScript functions to handle the modal's visibility.
```
<script>
  const modal = document.getElementById('crudModal');
  const modalContent = document.getElementById('crudModalContent');

  function showModal() {
      modal.classList.remove('hidden'); 
      setTimeout(() => {
        modalContent.classList.remove('opacity-0', 'scale-95');
        modalContent.classList.add('opacity-100', 'scale-100');
      }, 50); 
  }

  function hideModal() {
      modalContent.classList.remove('opacity-100', 'scale-100');
      modalContent.classList.add('opacity-0', 'scale-95');

      setTimeout(() => {
        modal.classList.add('hidden');
      }, 150); 
  }

  document.getElementById("cancelButton").addEventListener("click", hideModal);
  document.getElementById("closeModalBtn").addEventListener("click", hideModal);
</script>
```

We update the existing button and add a new button to trigger the modal.
```
<!-- Update buttons in main.html -->
<a href="{% url 'main:create_product_entry' %}" class="bg-indigo-400 hover:bg-indigo-400 text-white font-bold py-2 px-4 rounded-lg transition duration-300 ease-in-out transform hover:-translate-y-1 hover:scale-105 mx-4 ">
    Add New Product Entry
</a>
<button data-modal-target="crudModal" data-modal-toggle="crudModal" class="btn bg-indigo-700 hover:bg-indigo-600 text-white font-bold py-2 px-4 rounded-lg transition duration-300 ease-in-out transform hover:-translate-y-1 hover:scale-105" onclick="showModal();">
  Add New Product Entry by AJAX
</button>
```

NOTE: The modal is triggered by clicking a button on the main page. When adding a product entry successfully, the modal should be closed, and the form input should be cleared from the data entered before. If adding the product entry fails, show an error message.

- Create a new view function to add a new product entry to the database.

In views.py, we define a new function add_product_entry_ajax to handle the AJAX POST request.
```
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_POST
from django.utils.html import strip_tags

@csrf_exempt
@require_POST
def add_product_entry_ajax(request):
    name = strip_tags(request.POST.get("name"))  # strip HTML tags!
    description = strip_tags(request.POST.get("description"))  # strip HTML tags!
    price = request.POST.get("price")
    user = request.user

    new_product = ProductEntry(
        name=name, 
        description=description,
        price=price,
        user=user
    )
    new_product.save()

    return HttpResponse(b"CREATED", status=201)
```

- Create a /create-ajax/ path that routes to the new view function you created.

from main.views import ..., add_product_entry_ajax
```
urlpatterns = [
    ...
    path('create-product-entry-ajax', add_product_entry_ajax, name='add_product_entry_ajax'),
]
```

- Connect the form you created inside the modal to the /create-ajax/ path.

We create a JavaScript function addProductEntry to handle form submission via AJAX.
```
<script>
  function addProductEntry() {
    fetch("{% url 'main:add_product_entry_ajax' %}", {
      method: "POST",
      body: new FormData(document.querySelector('#productEntryForm')),
    })
    .then(response => refreshProductEntries());

    document.getElementById("productEntryForm").reset(); 
    document.querySelector("[data-modal-toggle='crudModal']").click();

    return false;
  }

  document.getElementById("productEntryForm").addEventListener("submit", (e) => {
    e.preventDefault();
    addProductEntry();
  });
</script>
```

- Perform asynchronous refresh on the main page to display the latest item list without reloading the entire main page.

WARNING: Make sure the AJAX GET and POST can be done securely.

Add a new product entry with the value of the mood field as follows. Other fields can be filled in according to your preference.
```
<img src=x onerror="alert('XSS!');">
```

Press the save button and if the storage is successful, you will get an alert with the value XSS!

Protecting the Application from Cross Site Scripting (XSS)

To ensure our application is secure against XSS attacks, we sanitize user input on both the server and client sides.

Adding strip_tags to "Clean Up" New Data

In views.py and forms.py, we import strip_tags and apply it to user inputs.

```
from django.utils.html import strip_tags

# In views.py, within add_product_entry_ajax
name = strip_tags(request.POST.get("name"))
description = strip_tags(request.POST.get("description"))
```

```
# In forms.py
class ProductEntryForm(ModelForm):
    class Meta:
        ...

    def clean_name(self):
        name = self.cleaned_data["name"]
        return strip_tags(name)

    def clean_description(self):
        description = self.cleaned_data["description"]
        return strip_tags(description)
```



After adding strip_tags, remove the data that you have just added and try to add it again. If you get an error on the form that says the mood field cannot be empty, then congratulations, you have added a security hole against XSS! If you do not get an error, check again whether you have followed the steps above.

Sanitizing Data with DOMPurify

On the client side, we use DOMPurify to sanitize data before rendering.
```
<!-- In main.html, add to the meta block -->
{% block meta %}
...
<script src="https://cdn.jsdelivr.net/npm/dompurify@3.1.7/dist/purify.min.js"></script>
...
{% endblock meta %}
```

In the refreshProductEntries function, we sanitize the product data.
```
<script>
  async function refreshProductEntries() {
      ...
      productEntries.forEach((item) => {
          const name = DOMPurify.sanitize(item.fields.name);
          const description = DOMPurify.sanitize(item.fields.description);
          // Use 'name' and 'description' instead of 'item.fields.name' and 'item.fields.description'
          ...
      });
      ...
  }
</script>
```

Warning: Ensure all occurrences of item.fields.name are replaced with name and item.fields.description with description.

Refresh the main page and if you have previously had dirty data like the alert box that shows up, then the alert box should no longer appear on the browser.

==============================================================================================================================================================================================================================================
=

Answer the following questions in README.md in the root folder (please modify the README.md you have created; add subheadings for each task).
= 

Explain the benefits of using JavaScript in developing web applications!
=

Using JavaScript allows us to create web applications that are dynamic and interactive. This means we can update parts of a page without reloading the whole page, respond to user actions, and enhance the user experience. As mentioned in the tutorial:

"The benefit of using JavaScript in web development is that dynamic page manipulation can be done and interaction between web pages and users can be increased."

Some examples include displaying information based on time, validating forms or data, and dynamically changing the style of elements. This makes our web applications more engaging and user-friendly.

Explain why we need to use await when we call fetch()! What would happen if we don't use await?
=

When we use fetch() to get data from a server, the response doesn't arrive instantly—it takes some time. By using await, we tell our code to wait for the fetch() operation to complete before moving on. If we don't use await, our code would try to use the data before it has arrived, leading to errors. The tutorial explains:

"The await function is used to wait for the result of an async function."

Without await, the code would continue executing, and any data-dependent operations would fail because the data isn't available yet.

Why do we need to use the csrf_exempt decorator on the view used for AJAX POST?
=

We need to use the csrf_exempt decorator because Django normally requires a CSRF token for POST requests as a security measure. When we make an AJAX POST request from JavaScript, we might not include this token. By adding @csrf_exempt, we tell Django to skip the CSRF token check for that specific view. As the tutorial states:

"The csrf_exempt decorator tells Django to not check the csrf_token in the POST request that is sent to the function."

This allows our AJAX POST request to succeed without triggering Django's CSRF protection.

On this week's tutorial, the user input sanitization is done in the back-end as well. Why can't the sanitization be done just in the front-end?
=

Sanitizing input only on the front-end isn't sufficient because users can bypass the front-end and send harmful data directly to our server. By performing sanitization on the back-end, we ensure that all data stored in our database is safe, even if someone tries to submit malicious input. The tutorial mentions:

"It is important to note that DOMPurify will only work if the data is retrieved to be displayed with HTML on the application's frontend. If there is an API /json or /xml used by the application, then the data that is obtained will still be 'dirty'."

This means relying solely on front-end sanitization leaves our application vulnerable, so back-end sanitization is necessary for security.

