// This is the Model Part of the MVVM Architecture

import 'package:cloud_firestore/cloud_firestore.dart'; // Importing Cloud Firestore

class FirestoreService {
  // Get the collection reference for subjects from Firestore
  final CollectionReference subjects =
      FirebaseFirestore.instance.collection("subjects");

  // CREATE: add a new subject in the database
  Future<void> addSubject(String subject) {
    return subjects.add({
      'subject' : subject, // Add subject data
      'date_created' : Timestamp.now(), // Add timestamp for date created
    });
  }

  // READ: call all the subjects in the database
  Stream<QuerySnapshot> getSubjectStream(){
    final subjectStream =
        subjects.orderBy('date_created', descending: true).snapshots(); // Get a stream of subjects ordered by date created
    
    return subjectStream; // Return the subject stream
  }

  // UPDATE: update subject based on the given ID
  Future<void> updateSubject(String docID, String newSubject) {
    return subjects.doc(docID).update({'subject' : newSubject}); // Update subject with new data
  }

  // DELETE: delete subject based on the given ID
  Future<void> deleteSubject(String docID) {
    return subjects.doc(docID).delete(); // Delete subject from Firestore
  }

}