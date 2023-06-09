# Fit Track

A training app made with Firebase.

# Application Video & Screenshots

https://user-images.githubusercontent.com/105479937/232328772-a773507d-4077-4ed7-84f1-4303fae6282f.mp4

![fit_track_ss](https://user-images.githubusercontent.com/105479937/232328970-4a27de93-5679-4fb5-93a2-97f0baab40ed.png)

# Firebase Auth Screenshot

![firebase_auth](https://user-images.githubusercontent.com/105479937/232328994-d0a6a906-5ef6-4f95-9552-f7f115600a47.png)


# Libraries:

Initialize the Flutter project, add all the necessary dependencies mentioned above in the **pubspec.yaml** configuration file and run `pub get`.

**pubspec.yaml**
```yaml
dependencies:
  flutter:
    sdk: flutter

  cupertino_icons: ^1.0.2

  #Text
  google_fonts: ^4.0.3

  #Responsive
  sizer: ^2.0.15

  #Image
  flutter_svg: ^2.0.5

  #Navigation
  go_router: ^6.2.0

  #Splash
  flutter_native_splash: ^2.2.19

  #State Management
  flutter_bloc:

  #Equality
  equatable:

  #Firebase
  firebase_core:
  cloud_firestore:
  firebase_auth:
  google_sign_in:

  #Local Storage
  flutter_secure_storage:

dev_dependencies:
  flutter_test:
    sdk: flutter

  flutter_lints: ^2.0.0

flutter_native_splash:
  color: "#ffffff"
  image: assets/images/splash.png  

flutter:
  fonts:
    - family: Moderat
      fonts:
        - asset: assets/fonts/Moderat-Bold.ttf
        - asset: assets/fonts/Moderat-Regular.ttf
  uses-material-design: true
  
  assets:
      - assets/icons/
      - assets/images/
  ```

## Folders

First of all, there are two main builds in our src>lib folder. These are view and core structures.

- core: This layer is the part that will manage or initiate the work that will do our main work.

base: This layer contains our main functions and singleton files.

components: This layer contains widgets that we can use on the pages, such as button, appbar, which we can create here and customize with parameters where we want to use them.

constants: This layer consists of two structures, these structures are app and enums structures.

extensions: This layer and the project contain the basic structure, String and int.

init: This layer consists of 3 main structures. These structures are cache , dependency_injection and routes.

- view: This layer contains our screens. We can create a folder for each screen. There is a folder for each page in the view.

