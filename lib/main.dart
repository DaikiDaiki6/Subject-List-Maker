import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
//import 'package:simple_crud/pages/home_page.dart'; // Importing HomePage
import 'package:simple_crud/pages/welcome_page.dart'; // Importing WelcomePage
import 'package:simple_crud/pages/home_view_model.dart'; // Importing HomeViewModel
import 'firebase_options.dart'; // Ensure you import your Firebase options

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Initialize Firebase with options
  runApp(MyApp()); // Run the application
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider( // Use ChangeNotifierProvider to provide HomeViewModel to the widget tree
      create: (context) => HomeViewModel(), // Create an instance of HomeViewModel
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Disable debug banner
        home: WelcomePage(), // Set HomePage as the initial route
      ),
    );
  }
}
