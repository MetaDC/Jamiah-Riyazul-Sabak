import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FBFireStore {
  static final fb = FirebaseFirestore.instance;
  static final subjects = fb.collection('subjects');
  static final students = fb.collection('students');
  static final classes = fb.collection('classes');
  static final teachers = fb.collection('teachers');
  static final courses = fb.collection('course');
  static final studentNotes = fb.collection('studentNotes');
}

class FBStorage {
  static final storage = FirebaseStorage.instance;
  static final studentNotes = storage.ref().child('studentNotes');
}
