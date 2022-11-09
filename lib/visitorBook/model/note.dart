import 'package:flutterweb/visitorBook/viewController/visitor_book_view_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'keyFiles.dart';

//Note
//title
//content : 내용
//date : 작성일자

class Note{
  Note({
    required this.title,
    required this.content,
    required this.date
  });

  String title = "";
  String content = "";
  String date = "";
}

void getNotesFromFirebase() {
    FirebaseFirestore.instance
      .collection('visitorBook')
      .orderBy("timestamp")
      .get()
      .then((QuerySnapshot querySnapshot) {
    List<Note> newNotes = [];
    querySnapshot.docs.forEach((doc) {
      newNotes.add(
        Note(
          title: doc["title"],
          content: doc["content"],
          date: doc["date"]
        ));
    });
    Get.find<VisitorBookViewController>().updateNotes(newNotes);
  });
}

Future<int> postNoteToFirebase(String title, String content) {
  return FirebaseFirestore.instance.collection('visitorBook')
    .add({
    'title': title,
    'content': content,
    "date": DateFormat("yyyy-MM-dd").format(DateTime.now()),
    "timestamp" : FieldValue.serverTimestamp()
  })
  .then((value) => 200)
  .catchError((error) => 404);
}