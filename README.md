# Supported devices
1. Android - minimum SDK Version 16 or jelly bean 
2. iOS - minimum os version 9

# Supported features.
1. User can see song list
2. User can search song by typing artist name
3. User can see which song is currently playing
4. Users can manage music controls to play songs or stop songs, besides that users can also select the next song or the previous song

# Requirements to build the app.
1. Install flutter, https://docs.flutter.dev/get-started/install
2. Add sdk flutter to android studio 
3. Install plugin in android studio
    - Flutter
    - Dart
    - Bloc
    - RxBloc
4. Create new flutter project 
5. Add all required dependencies in pubspec.yaml file
   in this project , we need : 
   - rx_bloc : a set flutter packages that help implement the bloc design patter using the power of reactive streams
   - rx_bloc_test : that facilitates implementing the unit tests for our BloCs
   - flutter_rx_bloc : that exposes your reactive BloCs to the UI Layer.
   - rx_bloc_generator : that boosts development efficiency by making your BloCs zero-boilerplate.
   - build_runner : provides a concrete way of generating files using Dart code, outside of tools like pub
   - equatable : helps to implement value based equality without needing to explicitly override
   - dio : a powerful Http client for Dart, which supports Interceptors, FormData, Request Cancellation, File Downloading, Timeout etc
   - provider : a wrapper around InheritedWidget to make them easier to use and more reusable.
   - audioplayers : a Flutter plugin to play multiple audio files simultaneously
6. Create code 
7. Create unit test

# Instructions to build and deploy the app.
- Build app 
1. Open terminal and type "flutter run"
2. Or run app using button run in android studio or visual studio code  
  
- Deploy the app
1. Change version / build number in pubspec.yaml if needed
2. Build app
   - Android / APK : Open terminal and type "flutter build apk"
   - ios / IPA : Open Xcode, choose menu product -> archive 
   


