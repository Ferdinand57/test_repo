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

Add 4 views to view the added objects in XML, JSON, XML by ID, and JSON by ID formats.

Create URL routing for each of the views added in point 2.



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
![image](https://github.com/user-attachments/assets/ea799bc6-331b-435c-8df8-97fc63ac9e21)
