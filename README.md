# Sourcya Flutter Boilerplate
This is the base code for creating cross-platform application using Flutter.

## Getting Started
To use this template to create new flutter application,

Follow these steps to start creating your own app:
1. click use this template to create a new repository with this code.
2. Clone the new repo to your local machine.
3. go to ``pubspec.yaml`` and update name, description and version for the new app.
4. Rename app name, package name  using [Rename package](https://pub.dev/packages/rename) and update app launcher icons.

you can install Rename package globally using
 ```Shell
 flutter pub global activate rename  
 ```

then if you dont pass **-t or --target** parameter it will try to rename all available platform project folders inside flutter project.

_**Run this command inside your flutter project root.**_
  ```Shell
        flutter pub global run rename --bundleId io.sourcya.newApp 
        flutter pub global run rename --appname "Sourcya app"
        flutter pub global run rename --appname YourAppName --target ios  
        flutter pub global run rename --appname YourAppName --target android  
        flutter pub global run rename --appname YourAppName --target web  
        flutter pub global run rename --appname YourAppName --target macOS  
        flutter pub global run rename --appname YourAppName --target windows  
```  

## Google Sign In
To setup Google sign in  in our flutter project, There is some configuration that needs to be done:

## Android
To use Google sign in in our app we need to sign our app with a keystore and extracts it's SHA key to be provided for the backend to register the app in Google cloud console with app package name and SHA key.

### Generating a keystore

If you need to create a new keystore file for signing your release builds, you can do so with the Java Keytool utility by running the following command:

```Shell
 keytool -genkey -v -keystore sourcya_keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias sourcya_key -keypass sourcya135 -storepass sourcya135 -dname "CN=Sourcya, OU=Sourcya, O=Sourcya, L=Egypt, ST=Alexandria, C=EG" 
```

Keytool then prompts you to enter your personal details for creating the certificate, as well as provide passwords for the keystore and the key. It then generates the keystore as a file called  **sourcya_keystore.jks**  in the directory you’re in. The key is valid for 10,000 days.


### Generate SHA-1

We can generate SHA-1  using the Java Keytool utility by running the following command:

```Shell
keytool -list -v -keystore "sourcya_key.jks" -alias sourcya_key -storepass sourcya135 -keypass sourcya135
```

### Ios
To use Google sign in in our app, The backend should create a client for ios using ios app bundle id.
Then a client id should be generated and put in ``core/keys.dart``.

Then update the  `CFBundleURLTypes`  attributes below into the  `[my_project]/ios/Runner/Info.plist`  file.

```xml
<!-- Put me in the [my_project]/ios/Runner/Info.plist file -->
<!-- Google Sign-in Section -->
<key>CFBundleURLTypes</key>
<array>
	<dict>
		<key>CFBundleTypeRole</key>
		<string>Editor</string>
		<key>CFBundleURLSchemes</key>
		<array>
			<!-- TODO Replace this value: -->
			<string>com.googleusercontent.apps.861823949799-vc35cprkp249096uujjn0vvnmcvjppkn</string>
		</array>
	</dict>
</array>
<!-- End of the Google Sign-in Section -->

```

### Web :
On your  `web/index.html`  file, add the following  `meta`  tag, somewhere in the  `head`  of the document:

```html
<meta name="google-signin-client_id" content="YOUR_GOOGLE_SIGN_IN_OAUTH_CLIENT_ID.apps.googleusercontent.com">
```

For this client to work correctly, the last step is to configure the  **Authorized JavaScript origins**, which  _identify the domains from which your application can send API requests._  When in local development, this is normally  `localhost`  and some port.

You can do this by:

1.  Going to the  [Credentials page](https://console.developers.google.com/apis/credentials).
2.  Clicking "Edit" in the OAuth 2.0 Web application client that you created above.
3.  Adding the URIs you want to the  **Authorized JavaScript origins**.

For local development, you must add two  `localhost`  entries:

-   `http://localhost`  and
-   `http://localhost:5000`  (or any port that is free in your machine)

#### Starting flutter in  [http://localhost:5000](http://localhost:5000/)

Normally  `flutter run`  starts in a random port. In the case where you need to deal with authentication like the above, that's not the most appropriate behavior.

You can tell  `flutter run`  to listen for requests in a specific host and port with the following:

```sh
flutter run -d chrome --web-hostname localhost --web-port 5000
```

Or from Android studio click on ``Main.dart`` next to run button
Then click on ``Edit Configuration`` a window will appear, on ``Addition run args``
add :  ``--web-port 5000``
now our web app run on the right configuration.


## App Signing
Any android app need to be signed to use google sign in and to be ready for publishing to Google play.
So we need to sign our app for debug and release version
#### Debug :
We need to put the generate keystore file in the ``android`` directory of your project.
We need to create named  `keystore.properties`  in the ``android`` directory of your project. This file should contain your signing information, as follows:

    storePassword=myStorePassword
    keyPassword=mykeyPassword
    keyAlias=myKeyAlias
    storeFile=myStoreFileLocation (../key.jks) it should be like this if keystore in android directory

Make sure don't push this file to the repo as it should be secret.

#### Release :

For release version,  The app need to be signed on code magic using a keystore file.
For more info check :
https://docs.codemagic.io/flutter-code-signing/android-code-signing/
https://docs.codemagic.io/yaml-code-signing/signing-android/


now we are ready to start developing our new app.

## Architecture
An app architecture defines the boundaries between parts of the app and the responsibilities each part should have. In order to meet the needs mentioned above, you should design your app architecture to follow a few specific principles.

### Separation of concerns

The most important principle to follow is  [separation of concerns](https://en.wikipedia.org/wiki/Separation_of_concerns). It's a common mistake to write all your code in `Widgets` . These UI-based classes should only contain logic that handles UI and operating system interactions. By keeping these classes as lean as possible, you can avoid many problems related to the component lifecycle, and improve the testability of these classes.

### Drive UI from data models

Another important principle is that you should drive your UI from data models, preferably persistent models. Data models represent the data of an app. They're independent from the UI elements and other components in your app. This makes the app more testable and robust.

### Single source of truth

When a new data type is defined in your app, you should assign a Single Source of Truth (SSOT) to it. The SSOT is the  _owner_ of that data, and only the SSOT can modify or mutate it. To achieve this, the SSOT exposes the data using an immutable type, and to modify the data, the SSOT exposes functions or receive events that other types can call.

This pattern brings multiple benefits:
- It centralizes all the changes to a particular type of data in one place.
- It protects the data so that other types cannot tamper with it.
- It makes changes to the data more traceable. Thus, bugs are easier to spot.


### Unidirectional Data Flow

The  single source of truth principle  is often used with the Unidirectional Data Flow (UDF) pattern. In UDF,  **state** flows in only one direction. The  **events** that modify the data flow in the opposite direction.

In Android, state or data usually flow from the higher-scoped types of the hierarchy to the lower-scoped ones. Events are usually triggered from the lower-scoped types until they reach the SSOT for the corresponding data type. For example, application data usually flows from data sources to the UI. User events such as button presses flow from the UI to the SSOT where the application data is modified and exposed in an immutable type.

This pattern better guarantees data consistency, is less prone to errors, is easier to debug and brings all the benefits of the SSOT pattern.

### MVVM Architecture Pattern:

The app is built using MVVM architecture Pattern.

MVVM stands for Model, View, View Model.

#### Model:
Model represents the data and business logic of the app. One of the recommended implementation strategies of this layer, is to expose its data through observables to be decoupled completely from View Model or any other observer/consumer.

#### View Model:
It acts as a link between the Model and the View. It provides the data for a specific UI component which are the widgets , and contains data handling business logic to communicate with the model. For example, the View Model can call other components to load the data, and it can forward user requests to modify the data. The View Model doesn't know about UI components, so it isn't affected by configuration changes, such as recreating an activity when rotating the device. One of the important implementation strategies of this layer is to decouple it from the View, i.e. View Model should not be aware about the view who is interacting with.

#### View:
the view role in this pattern is to observe a View Model observable to get data in order to update UI elements accordingly.

The following flow illustrates the core MVVM Pattern.
<p align="center">  
  <img width= "50%"  src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/MVVMPattern.png/500px-MVVMPattern.png">  
</p>  

## App Architecture
Considering the common architectural principles mentioned in the previous section, each application should have at least two layers:
- The  _UI layer_ that displays application data on the screen.
- The  _data layer_ that contains the business logic of your app and exposes application data.

You can add an additional layer called the  _domain layer_ to simplify and reuse the interactions between the UI and data layers.
<p align="center">  
  <img width= "50%"  src="https://developer.android.com/static/topic/libraries/architecture/images/mad-arch-overview.png">  
</p>  


### UI layer
The role of the UI layer (or  _presentation layer_) is to display the application data on the screen. Whenever the data changes, either due to user interaction (such as pressing a button) or external input (such as a network response), the UI should update to reflect the changes.

The UI layer is made up of two things:

- UI elements that render the data on the screen. You build these elements using Widgets.
- State holders that hold data, expose it to the UI, and handle logic. We are currently using [Getx State Mangement](https://pub.dev/packages/get).
<p align="center">  
  <img width= "50%"  src="https://developer.android.com/static/topic/libraries/architecture/images/mad-arch-overview-ui.png">  
</p>  


For our app our ui layer consits of :

1. view : contains our screen widget. if our view is big consider separating the widget into smaller widgets.
2. controller: which contains getx controller which controls the data that is coming from our data layer and handling ui events. It's main responsiblity is to update our view.
3. binding : Bindings are classes where we can declare our dependencies and then _bind_ them to the routes. it should be used to initialize view controller.

<p align="center">  
  <img width= "60%"  src="https://i.imgur.com/Jy6Cab6.png">  
</p>  


### Data layer

The data layer of an app contains the  _business logic_. The business logic is what gives value to your app—it's made of rules that determine how your app creates, stores, and changes data.

The data layer is made of  _repositories_ that each can contain zero to many  _data sources_. You should create a repository class for each different type of data you handle in your app. For example, you might create a  `MoviesRepository` class for data related to movies, or a  `PaymentsRepository` class for data related to payments.

<p align="center">  
  <img width= "50%"  src="https://developer.android.com/static/topic/libraries/architecture/images/mad-arch-overview-data.png">  
</p>  

Repository classes are responsible for the following tasks:

- Exposing data to the rest of the app.
- Centralizing changes to the data.
- Resolving conflicts between multiple data sources.
- Abstracting sources of data from the rest of the app.
- Containing business logic.

Each data source class should have the responsibility of working with only one source of data, which can be a file, a network source, or a local database. Data source classes are the bridge between the application and the system for data operations.

The repository should decide where the data should come from which data source to the ui layer.  
For example we might only need data from api then later we need to add caching using database so we create data source for  the database. In this case the repo should handle how we get data from the api and database and only return the right data for the ui.

For our data layer on the app :  
We should create a data layer for each feature.   
each future can consists of one data layer and one or more ui layer.

As we described earlier our data layer consists of :

1. Model : data model for the feature.   
   Based on the app use case we may consider creating different models for each data like creating model for data that are coming from api and different model for data coming from database and model for the ui.
3. Data Source: getting data from a single source like api, database , etc.
4. Repo: Get data from data sources and make it ready for the ui layer.

<p align="center">  
  <img height="10%" src="https://i.imgur.com/38slWfH.png">  
</p>  

## Package by Feature
In this project structure, packages contain all classes that are required for a feature. The independence of the package is ensured by placing closely related classes in the same package. An example of this structure is given below:
```├── app    
    └── auth  
        ├── data  
            ├── model  
            ├── datasources  
            └── repo  
        └── ui  
            ├── bindings  
            ├── controller  
            └── view  
    └── product    
        ├── data  
            ├── model  
            ├── datasources  
            └── repo  
        └── ui  
            ├── bindings  
            ├── controller  
            └── view  
```  
— Package by Feature has packages with  **high cohesion, low coupling** and  **high modularity.**

— Package by Feature allows some classes to set their access modifier  `package-private` instead of  `public`, so it increases  **encapsulation**. On the other hand, Package by Layer forces you to set nearly all classes  `public`.

— Package by Feature reduces the need to navigate between packages since all classes needed for a feature are in the same package.

— Package by Feature is like microservice architecture. Each package is limited to classes related to a particular feature. On the other hand, Package By Layer is monolithic. As an application grows in size, the number of classes in each package will increase without bound.

## App Components
Our app consists of 2 components:

### App:
This component is responsible for all app features as it contains each feature that are packaged together by Feature as described in previous example.

Each Feature can have one or more screen as each screen has it's own ui layer and screens have one data layer or can share it with another screen.
<p align="center">  
  <img height="10%" src="https://i.imgur.com/wf5K451.png">  
</p>  

### Core Component :

This component contains different pieces of code that are shared between the whole app.
<p align="center">  
  <img height="10%" src="https://i.imgur.com/osnLXT5.png">  
</p>  


It contains different components:
#### Config :
This component contains app configuration like playx configuration, keys and constants .

#### Preferences:
Handles saving value/pair keys in shared preferences in one place.

#### Utils:
Provides different utilities for whole app like alrets, pickers, app utils and more.

#### Widgets:
Provides different Widgets that are shared between the app.

#### Navigation:
Handles app navigation in one place.   
First create your app routes.  
Then every navigation between routes should be done in app navigation class.  
To make it easier to maintain same behavior for navigation and make it easy if we want to use another solution for navigation in the future.

For Example :  
if you want to navigate from splash to home screen navigate using this.
```    
    void navigateFormSplashToHome() {    
         Get.offAllNamed(Routes.HOME);    
     }  
```  
#### Network:
This provides us with an api client that can do different REST calls.  
The client make it easy to perform GET, POST, PUT, DELETE requests for the api.

Currently we are using [Dio](https://pub.dev/packages/dio) which is a powerful HTTP package for Dart/Flutter, which supports Global settings, Interceptors, FormData, Aborting and canceling a request, Files uploading and downloading, Requests timeout, Custom adapters, etc.

Here is an example for getting movie details using ``GET`` request :
```dart  
Future<NetworkResult<Movie>> getMovieDetails(    
  String id,    
) async {    
   return client.get<Movie>(    
        Endpoints.movieDetails,    
        query: {    
          'id': id,    
             },    
       fromJson: Movie.fromMap,    
  );    
}  
```  
We use the suitable methods of our api client like get and pass the model that will be returned.  
It takes request endpoint and query and It needs from json function that converts the response to the right model.  
The previous example returns ``NetworkResult<Movie>`` where movie is the model returned from reponse.  
and NetworkResult is wrapper for the data which return the result of the request if it's successful it returns the data and if it's error it return ``NetworkException`` .

``NetworkException`` is a base class for handling most api errors and provides suitable error messages for each exception.  
You can customize these error messages and what errors should appear.  
Take alook at ``ApiHandler`` and ``NetworkException`` class for customization based on you needs.

You can also customise ``ApiError`` class to be the same as api error response based on your backend.

#### Resources:
Here we are handling app resources like themes, color, translations and assets.

##### Themes :
Here we put our app theme.  
We are using Playx Theme to handle app theme change and theme coloring.

```dart  
class AppThemeConfig extends XThemeConfig {    
  @override    
  List<XTheme> get themes => [    
       LightTheme.theme,    
       DarkTheme.theme,    
  ];    
}  
```  

For each theme of our app we create a file with different theme data and color scheme.

Here is an example of light theme :
```dart  
abstract class LightTheme {  
  static String lightTheme = 'light';  
  static String lightThemeName = 'Light';  
  
  static XTheme get theme => XTheme(  
        id: lightTheme,  
        nameBuilder: () => lightThemeName,  
        theme: ThemeData.light().copyWith(  
          appBarTheme: const AppBarTheme(  
            centerTitle: true,  
            backgroundColor: AppColors.appBarLight,  
          ),  
          primaryColor: AppColors.primaryLight,  
          colorScheme: const ColorScheme.light(  
            primary: AppColors.primaryLight,  
            secondary: AppColors.secondaryLight,  
            background: AppColors.backgroundLight,  
            surface: AppColors.surfaceLight,  
            error: AppColors.errorLight,  
            onPrimary: AppColors.onPrimaryLight,  
            onSecondary: AppColors.onSecondaryLight,  
            onBackground: AppColors.onBackgroundLight,  
            onSurface: AppColors.onSurfaceLight,  
            onError: AppColors.onErrorLight,  
          ),  
          scaffoldBackgroundColor: AppColors.backgroundLight,  
          textTheme: GoogleFonts.rubikTextTheme(),  
          sliderTheme: const SliderThemeData(  
            showValueIndicator: ShowValueIndicator.always,  
          ),  
        ),  
      );  
}  
```  
##### App Colors:
This class is responsible for providing colors for the app.  
To avoid boilerplate code and make it easier to change colors for the app.

##### App Assets:
This class is responsible for providing asset's items paths.  
You can use it or use class that is auto generated from assets plugin in Android studio.

#### Translation:
We are using Getx To handle translation for our app.

1. Create App Trans class :  
   This class contains all keys for each word that need to be translated in the app.
```dart  
abstract class AppTrans {  
  static const String appName = "app_name";  
  static const String requestCancelled = "requestCancelled";  
  static const String unauthorizedRequest = "UnauthorizedRequest";  
}  
```  
2. Create Translation file for each locale for the app with keys from AppTrans class.
```dart  
class EnglishTranslation extends BaseTranslation {  
  @override  
  Map<String, String> get translations => {  
        AppTrans.appName: "Sourcya App",  
        AppTrans.requestCancelled: "The request has been canceled",  
        AppTrans.unauthorizedRequest: "Unauthorized Request",  
       };  
}  
```  
3. Then we create our app locale class that handles translations.
```dart  
class AppLocale extends Translations {  
  static const String arabicLanguage = "ar";  
  static const String englishLanguage = "en";  
  
  ArabicTranslations arabicTranslations = ArabicTranslations();  
  EnglishTranslation englishTranslation = EnglishTranslation();  
  
  @override  
  Map<String, Map<String, String>> get keys => {  
        arabicLanguage: arabicTranslations.translations,  
        englishLanguage: englishTranslation.translations  
      };  
}  
```  
Now using AppTrans class for saving keys for each word we can easily use it for translations.  
For example when we need appName translate we use it like this ``AppTrans.appName.tr``

This will make it easier to avoid conflicts in naming instead of using ``'app_name'.tr`` .  
It will makes us avoid boilerplate code.  
It will make it easier to replace our translation tool in the future.


## References :

1. [Guide to app architecture](https://developer.android.com/topic/architecture) By android
2. [Ui Layer](https://developer.android.com/topic/architecture/ui-layer) By android
3. [Data Layer](https://developer.android.com/topic/architecture/data-layer) By android
4. [How To Use MVVM in Flutter](https://betterprogramming.pub/how-to-use-mvvm-in-flutter-4b28b63da2ca)
5. [Package by Layer vs Package by Feature](https://medium.com/sahibinden-technology/package-by-layer-vs-package-by-feature-7e89cde2ae3a)
6. [Dio](https://pub.dev/packages/dio)
7. [Getx](https://pub.dev/packages/get)