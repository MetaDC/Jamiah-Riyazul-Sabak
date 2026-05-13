import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jamiah_riyazul_sabak/model/classmodel.dart';
import 'package:jamiah_riyazul_sabak/model/studentnotemodel.dart';
import 'package:jamiah_riyazul_sabak/shared/const/firbase.dart';
import '../model/studentmodel.dart';
import '../services/image_picker.dart';

class HomeController extends GetxController {
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? classStream;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? studentStream;

  List<Studentmodel> students = [];
  List<Studentmodel> filteredStudents = [];
  List<StudentNoteModel> records = [];
  List<ClassModel> allClasses = [];
  bool isLoading = false;
  bool isSaving = false;

  @override
  void onInit() {
    super.onInit();
    loadStudents();
    getClassData();
  }

  void setLoading(bool value) {
    isLoading = value;
    isSaving = value;
    update();
  }

  /// 🔹 LOAD STUDENTS
  void loadStudents() {
    FBFireStore.students.snapshots().listen((snapshot) {
      students = snapshot.docs
          .map((doc) => Studentmodel.fromSnapshot(doc))
          .toList();

      filteredStudents = students;
      update();
    });
  }

  getClassData() async {
    try {
      classStream?.cancel();
      classStream = FBFireStore.classes.snapshots().listen((classEvent) {
        debugPrint("Total classes: ${classEvent.size}");

        allClasses = classEvent.docs
            .map((doc) => ClassModel.fromSnapshot(doc))
            .toList();
        update();
      });
    } catch (e) {
      debugPrint("Error in getClassData: $e");
    }
  }

  /// 🔹 SEARCH
  void searchStudent(String query) {
    if (query.isEmpty) {
      filteredStudents = students;
    } else {
      filteredStudents = students.where((s) {
        return s.name.toLowerCase().contains(query.toLowerCase()) ||
            s.grNO.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    update();
  }

  /// 🔹 LOAD RECORDS
  Future<void> getStudentRecords(String studentDocId) async {
    try {
      final snap = await FBFireStore.studentNotes
          .where('studentId', isEqualTo: studentDocId)
          .orderBy('date', descending: true)
          .get();

      records = snap.docs.map((e) => StudentNoteModel.fromSnapshot(e)).toList();

      update();
    } catch (e) {
      debugPrint('Firestore index not ready yet: $e');
    }
  }

  Future<String?> uploadImage(SelectedImage image) async {
    try {
      final String extension = image.extension.toLowerCase();
      final String contentType = extension == 'jpg' || extension == 'jpeg'
          ? 'image/jpeg'
          : 'image/$extension';

      final ref = FBStorage.studentNotes.child(
        '${DateTime.now().millisecondsSinceEpoch}.${image.extension}',
      );
      final uploadTask = await ref.putData(
        image.uInt8List,
        SettableMetadata(contentType: contentType),
      );
      final String url = await uploadTask.ref.getDownloadURL();
      debugPrint('Successfully uploaded image: $url');
      return url;
    } catch (e) {
      debugPrint('Error uploading image: $e');
      return null;
    }
  }

  Future<void> addRecord({
    required Studentmodel student,
    required String date,
    required String para,
    required String remarks,
    String? imageUrl,
  }) async {
    final record = StudentNoteModel(
      docId: '',
      studentId: student.docId,
      studentName: student.name,
      date: DateTime.parse(date),
      para: para,
      remarks: remarks,
      imageUrl: imageUrl,
    );

    await FBFireStore.studentNotes.add(record.toMap());

    await getStudentRecords(student.docId);
  }
}
