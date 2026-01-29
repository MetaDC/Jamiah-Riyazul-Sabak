import 'package:cloud_firestore/cloud_firestore.dart';

class FBFireStore {
  static final fb = FirebaseFirestore.instance;
  static final subjects = fb.collection('subjects');
  static final students = fb.collection('students');
  static final classes = fb.collection('classes');
  static final teachers = fb.collection('teachers');
  static final courses = fb.collection('course');
  static final studentNotes = fb.collection('studentNotes');
}
