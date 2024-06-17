// This is the ViewModel Part of the MVVM Architecture

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_crud/services/firestore.dart'; // Importing Firestore service

class HomeViewModel extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService(); // Instance of FirestoreService
  final TextEditingController textController = TextEditingController(); // Controller for text input

  Stream<QuerySnapshot> get subjects => _firestoreService.getSubjectStream(); // Stream of subjects from Firestore

  // Function to add or update subject
  void addOrUpdateSubject(String? docID) {
    if (docID == null) {
      _firestoreService.addSubject(textController.text); // Add new subject
    } else {
      _firestoreService.updateSubject(docID, textController.text); // Update existing subject
    }
    textController.clear(); // Clear text input after adding or updating subject
  }

  // Function to delete subject
  void deleteSubject(String docID) {
    _firestoreService.deleteSubject(docID); // Delete subject from Firestore
  }
}
