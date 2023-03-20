# **Contributing to the project**

 - [Coding Rules](#rules)
 - [Commit Message Guidelines](#commit)
 - [Code Style](#style)
 - [Code Structure](#structure)

## <a name="rules"></a> **Coding Rules**

To ensure consistency throughout the source code, keep these rules in mind as
you are working:

* All features or bug fixes **must be tested**
* All public API methods **must be documented**
* Python code must PEP8 conform
* All new features **must not** increase technical debt messured by SonarQube

### **Black**

We use black to format code in this repository, see
[black documentation](https://black.readthedocs.io/en/stable/integrations/editors.html)
for instructions on how to configure black to work with your code editor.

### **SonarQube**

The easiest way to use SonarQube is to install the IntelliJ or PyCharm,
plugin:

1. Preferences -> plugin search "sonarlint"
2. Restart IDE
3. Add configuration "Settings" -> "Other Settings" -> "SonarLint General Settings"
4. Add new *server*: https://sonarqube.cocus.com
5. Choose *Login / Password* and use your COCUS LDAP credentials
6. Bind SonarQube to project: "Other Settings" -> "SonarLint Project Settings"
7. Select Server in "Bind to server" and choose the project

The SonarQube checks will be performed automatically after a file is saved.
## <a name="commit"></a> **Git Commit Guidelines**

We have very precise rules over how our git commit messages can be formatted.
This leads to **more readable messages** that are easy to follow when looking
through the **project history**.

### **Commit Message Format**

Each commit message consists of a **header**, a **body** and a **footer**.  The
header has a special format that includes a **type**, a **scope** and a
**subject**:

```
<type>(<scope>): <subject>
<BLANK LINE>
<body>
<BLANK LINE>
<footer>
```

The **header** is mandatory and the **scope** of the header is optional.

Any line of the commit message cannot be longer 100 characters! This allows the
message to be easier to read on GitLab as well as in various Git tools.

### **Revert**

If the commit reverts a previous commit, it should begin with `revert: `,
followed by the header of the reverted commit. In the body it should say: `This
reverts commit <hash>.`, where the hash is the SHA of the commit being
reverted.

### **Type**
Must be one of the following:

* **feat**: A new feature
* **fix**: A bug fix
* **docs**: Documentation only changes
* **style**: Changes that do not affect the meaning of the code (white-space, 
  formatting, missing semi-colons, etc)
* **refactor**: A code change that neither fixes a bug nor adds a feature
* **perf**: A code change that improves performance
* **test**: Adding missing tests
* **chore**: Changes to the build process or auxiliary tools and libraries 
  such as documentation generation

### **Scope**

The scope should be any related ticket from either GitLab or QualityCenter, if
no related ticket is available scope may be left blank. 

### **Subject**

The subject contains succinct description of the change:

* use the imperative, present tense: "change" not "changed" nor "changes"
* don't capitalize first letter
* no dot (.) at the end

**A properly formed git commit subject line should always be able to complete
the following sentence:**

* If applied, this commit will `your subject line here`
 
For example:

* If applied, this commit will refactor subsystem X for readability
* If applied, this commit will update getting started documentation
* If applied, this commit will remove deprecated methods
* If applied, this commit will release version 1.0.0
* If applied, this commit will merge pull request #123 from user/branch

Notice how this doesn't work for the other non-imperative forms:

* If applied, this commit will fixed bug with Y
* If applied, this commit will changing behavior of X
* If applied, this commit will more fixes for broken stuff
* If applied, this commit will sweet new API methods

### **Body**

Just as in the **subject**, use the imperative, present tense: "change" not
"changed" nor "changes".  The body should include the motivation for the change
and contrast this with previous behavior.

**Use the body to explain what and why vs. how**

In most cases, you can leave out details about how a change has been made. Code
is generally self-explanatory in this regard (and if the code is so complex
that it needs to be explained in prose, that's what source comments are for).
Just focus on making clear the reasons you made the change in the first
place—the way things worked before the change (and what was wrong with that),
the way they work now, and why you decided to solve it the way you did.

The future maintainer that thanks you may be yourself!

### **Commit split**

When we move classes/methods/functions around, we split this change into a separate 
commit to improve the readability of diffs. This change is marked as a `refactor` 
commit. Moreover, we keep any refactoring in separate commits to make the code 
review process easier and to keep the git history refined.


## <a name="style"></a> **Code Style**

### **URL Naming**

We follow the below convention for naming urls in django app:

1. The **app_name** attribute must be set in each urls.py file to specify the
application namespace and its value must be identical to the app name.

2. A **name** attribute must be provided for each url pattern and the following
   name patterns are applied.

   When the model_name matches the app_name:
   * list view: list
   * create view: create
   * detail view: detail
   * update view: update
   * delete view: delete

   When the model_name does not match the app_name:
   * list view: model_name-list
   * create view: model_name-create
   * detail view: model_name-detail
   * update view: model_name-update
   * delete view: model_name-delete

   Non model related views are to be named as the view.

3. For a Truck model of the trucks app, the URLs should be styled as follows:

```python
app_name = 'trucks'
urlpatterns = [
    path('list/', Trucks.as_view(), name='list'),
    path('create/', CreateTruck.as_view(), name='create'),
    path('<int:truck_id>/', Truck.as_view(), name='detail'),
    path('<int:truck_id>/update/', UpdateTruck.as_view(), name='update'),
    path('choose-window-color/', ChooseWindowColor.as_view(), name='choose-window-color'),
    path('<int:truck_id>/window/create/', CreateWindow.as_view(), name='window-create'),
    path('<int:truck_id>/window/<int:window_id>/', Window.as_view(), name='window-detail'),
    path('<int:truck_id>/window/<int:window_id>/update/', UpdateWindow.as_view(), name='window-update'),
]
```

### **Settings import in code**

When importing options from settings we import `django.conf.settings` module
as recomended by django's documentation and not import from settings module directly

```python
# GOOD
from django.conf import settings
do_thing(setting=settings.SECRET_KEY)

# BAD
from project import settings
from project.settings import SECRET_KEY
do_thing(setting=SECRET_KEY)
do_thing(setting=settings.SECRET_KEY)
```

## <a name="style"></a> **Code Structure**

### **Celery tasks module**

if there is a Django application containing several celery tasks in a `tasks.py` file, they shall be grouped in `celery_tasks` module at the root of the Django app. Any celery task of that module shall be placed in a distinct file named `{celery_task_name}.py` for better explicitness and code navigation.


### **Custom migration**
When writing a custom migration, we add `migrations.RunPython.noop` as `reverse_code` of `migrations.RunPython` 
migration operation when we know that no action will need to be performed to reverse it.

```python
class Migration(migrations.Migration):
    ...
    operations = [
        migrations.RunPython(forward,  reverse_code=migrations.RunPython.noop),
    ]
    ...
```
If the `reverse_code` value is not provided, the system will raise `django.db.migrations.exceptions.IrreversibleError`
exception ([docs](https://docs.djangoproject.com/en/4.1/topics/migrations/#reversing-migrations))
when migrating backward that might not be expected behavior in some cases.

### **Tests**
#### **Patching**
When using `patch`, we patch inside of a test and **not** using a decorator.
```python
# GOOD
def test_foobar(self):
    patch('foo.bar').start()
    ...

# BAD
@patch('foo.bar')
def test_foobar(self, foo_patch):
    ...
```
This leads to fewer merge conflicts and no unused test method parameters.

#### **Patching of settings**
When we need to change settings for tests we use one of functions provided by django
for tests, and not patch settings module directly
```python
# GOOD:
@modify_settings(...):
class ConditionTestCase:
   @override_settings(...):
   def test_condition(self) -> None:
       with self.settings(...):
       ...

# BAD
patch('app.module.django.conf.settings', return_value={...})
```

#### **Assertions**
Even though python does not dictate it we want the first argument of an
`assertEqual` to be the expected and the second the actual value.

#### **Creation of model instances**
When possible prefer to use `baker` module to create model instances for tests.

For example given model
```python
class Person(models.Model):
    first_name = models.CharField(max_length=255, blank=False, null=False, unique=True)
    last_name = models.CharField(max_length=255, blank=False, null=False, unique=True)
    age = models.IntegerField()
    address = models.ForeignKey("addresses.Address", on_delete=models.PROTECT)
```

if you want to create instances from this model in the test and you only care value of `age` field then it is much
easier to write and later for someone else to understand the purpose of the test if you write
```python
person = baker.make("persons.Person", age=10)
```

than if you had to provide all required fields for this model
```python
address = <something that gets address>
person = Person.objects.create(
    first_name="unimportant first name that has to be unique",
    last_name="unimportant last name that has to be unique",
    age=10
    address=address,
)
```

This results in tests that are shorter and easier to understand.

Note that sometimes baker cannot do everything by himself and you either are required to provide some values to it or
cannot use it altogether. In this case if this is something that is needed in multiple tests then prefer to extract it
into a separate function.
