import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app.example.com/RecipeApp/provider/favorite_provider.dart';
// import 'package:recipe_app.example.com/RecipeApp/provider/onpagechanged.dart';
import 'package:recipe_app.example.com/RecipeApp/provider/q_provider.dart';
// import 'package:recipe_app.example.com/RecipeApp/provider/q_provider.dart';
// import 'package:recipe_app.example.com/RecipeApp/provider/q_provider.dart';
// import 'package:recipe_app.example.com/RecipeApp/provider/q_provider.dart';
// import 'package:recipe_app.example.com/RecipeApp/provider/quantity_provider.dart';
import 'package:recipe_app.example.com/RecipeApp/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyC0qmB1yOZuZRApPlkHaiJoK4RTvAemGlU",
            authDomain: "recipeapp-195a9.firebaseapp.com",
            databaseURL: "https://recipeapp-195a9-default-rtdb.firebaseio.com",
            projectId: "recipeapp-195a9",
            storageBucket: "recipeapp-195a9.appspot.com",
            messagingSenderId: "419314273882",
            appId: "1:419314273882:web:ac25ee1aedc4b648759263",
            measurementId: "G-L6WWHVEV3V"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(create: (context) => QuantityProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(useMaterial3: false),
        home: const SplashScreen(),
      ),
    );
  }
}
