// lib/pages/home_page.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_crud/pages/home_view_model.dart'; // Importing necessary dependencies
import 'package:simple_crud/pages/welcome_page.dart'; // Importing WelcomePage

class HomePage extends StatelessWidget {
  const HomePage({super.key}); // Constructor for HomePage widget

  // Function to open the subject dialog box
  void openSubjectBox(BuildContext context, {String? docID}) {
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false); // Accessing the HomeViewModel using Provider
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          height: 200, // Set a fixed height for the dialog content
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  title: Text(
                    docID == null ? "New Subject" : "Edit Subject", // Conditional title based on whether docID is provided
                    style: TextStyle(color: Colors.black, fontSize: 15.0),
                  ),
                  toolbarHeight: 30.0, // Adjust toolbar height as needed
                  centerTitle: false, // Align title to the left
                ),
                TextField(
                  controller: homeViewModel.textController, // TextField for subject input
                ),
              ],
            ),
          ),
        ),
        actions: [
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
              homeViewModel.addOrUpdateSubject(docID); // Function to add or update subject
              Navigator.pop(context); // Close the dialog
            },
            child: Text(docID == null ? "Add Subject" : "Edit Subject"), // Text on the button
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(), // Providing the HomeViewModel to the widget tree
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue, // Background color for app bar
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => WelcomePage()),
              );
            },
          ),
        ),
        floatingActionButton: SizedBox(
          child: FloatingActionButton(
            onPressed: () => openSubjectBox(context), // Open subject dialog box when FloatingActionButton is pressed
            backgroundColor: Colors.blue, // Set background color to blue
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add), // Icon for add action
                SizedBox(height: 5), // Add some space between icon and text
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0), // Adjust padding
              alignment: Alignment.centerLeft, // Align text to the left
              child: Text(
                'Subjects', // Title for the list of subjects
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Consumer<HomeViewModel>(
                builder: (context, homeViewModel, child) {
                  return StreamBuilder<QuerySnapshot>(
                    stream: homeViewModel.subjects, // Stream of subjects from Firestore
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List subjectList = snapshot.data!.docs;

                        return ListView.builder(
                          itemCount: subjectList.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot document = subjectList[index];
                            String docID = document.id;

                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            String subjectText = data['subject']; // Get subject text from Firestore

                            return ListTile(
                              title: Text(subjectText), // Display subject text
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () => openSubjectBox(context, docID: docID), // Open edit dialog box
                                    icon: const Icon(Icons.edit, color: Colors.blue), // Icon for edit action
                                  ),
                                  IconButton(
                                    onPressed: () => homeViewModel.deleteSubject(docID), // Delete subject
                                    icon: const Icon(Icons.delete, color: Colors.red), // Icon for delete action
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return const Text("No subject"); // Display message when no subjects are available
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
