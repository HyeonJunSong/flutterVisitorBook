import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutterweb/visitorBook/model/constants.dart';
import 'package:flutterweb/visitorBook/model/note.dart';

class VisitorBookViewController extends GetxService{
  RxMap<String, Note> notes = <String, Note>{}.obs;
//  RxList<Note> notes = tempList.obs;

  void updateNotes (Map<String, Note> newNotes) {
    notes(newNotes);
  }

  void getNotes(){
    getNotesFromFirebase();
  }

  Future<int> postNote(String title, String content){
    return postNoteToFirebase(title, content);
  }
  Future<int> addComment(String key, String newComment){
    return addCommentFirebase(key, newComment).then(
      (value) {
        if(value == 200){
          notes[key]!.comments.add(newComment);
          return 200;
        }
        else {
          return value;
        }
      }
    );
  }

}