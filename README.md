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

AJAX GET
=

- Modify the codes in data cards to able to use AJAX GET.

- Retrieve data using AJAX GET. Make sure that the datas retrieved are only the datas belonging to the logged in user.

AJAX POST
=

- Create a button that opens a modal with a form for adding a mood entry.

NOTE: The modal is triggered by clicking a button on the main page. When adding a mood entry successfully, the modal should be closed, and the form input should be cleared from the data entered before. If adding the mood entry fails, show an error message.

- Create a new view function to add a new mood entry to the database.

- Create a /create-ajax/ path that routes to the new view function you created.

- Connect the form you created inside the modal to the /create-ajax/ path.

- Perform asynchronous refresh on the main page to display the latest item list without reloading the entire main page.

WARNING: Make sure the AJAX GET and POST can be done securely.

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

