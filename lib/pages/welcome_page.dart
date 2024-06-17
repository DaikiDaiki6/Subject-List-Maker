// lib/pages/welcome_page.dart

import 'package:flutter/material.dart';
import 'home_page.dart'; // Importing HomePage

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          color: Colors.blue, // Background color for app bar
          alignment: Alignment.center,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png', // Ensure you have an image named logo.png in the assets folder
              height: 200.0, // Set the height of the logo
            ),
            SizedBox(height: 20),
            Text(
              'Barroga  - Daquigan - Fajardo - Uy',
              style: TextStyle(
                fontSize: 18.0, // Font size for the title
                fontWeight: FontWeight.bold, // Bold font weight for the title
                color: Color.fromARGB(255, 1, 70, 126),
                fontFamily: 'YourFontFamily',
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.blue.withOpacity(0.5); // Disabled color for button
                    }
                    return Colors.blue; // Enabled color for button
                  },
                ),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Text color for button
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ), // Square shape for button
                side: MaterialStateProperty.all<BorderSide>(BorderSide(color: Colors.black, width: 2.0)), // Black border for button
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text('Go to HomePage'),
            ),
          ],
        ),
      ),
    );
  }
}
