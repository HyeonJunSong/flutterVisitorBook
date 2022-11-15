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
    required this.date,
    required this.comments,
  });

  String title = "";
  String content = "";
  String date = "";
  List<String> comments = [];
}

void getNotesFromFirebase() {
  FirebaseFirestore.instance
  .collection('visitorBook')
//      .orderBy("timestamp")
//      .doc(page.toString().padLeft(2, '0'))
  .doc("notes")
  .get()
  .then((DocumentSnapshot doc) {

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    List<Note> newNotes = [];
    data.forEach((key, value) {
      Map<String, dynamic> newNote = value as Map<String, dynamic>;

      //잘못된 형식의 노트는 넘기기 위한 try catch 문
      try {
        newNotes.add(
          Note(
            title: value["title"],
            content: value["content"],
            date: value["date"],
            comments: List<String>.from(value["comments"]),
          ),
        );
      }catch(error){
        print(error);
      };

    });
    
    Get.find<VisitorBookViewController>().updateNotes(newNotes);
  });
}

Future<int> postNoteToFirebase(String title, String content) {
  return FirebaseFirestore.instance.collection('visitorBook')
    .doc("notes")
    .update({
      //key값은 millisecond로 해서 concurrency 방지
      DateTime.now().millisecondsSinceEpoch.toString() : {
        "title" : title,
        "content" : content,
        "date": DateFormat("yyyy-MM-dd").format(DateTime.now()),
        "comments" : []
      }
    })
    .then((value) => 200)
    .catchError((error) => 404);
  //   .add({
  //   'title': title,
  //   'content': content,
  //   "date": DateFormat("yyyy-MM-dd").format(DateTime.now()),
  //   "timestamp" : FieldValue.serverTimestamp()
  // })
  // .then((value) => 200)
  // .catchError((error) => 404);
}