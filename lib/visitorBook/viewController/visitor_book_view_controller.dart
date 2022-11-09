import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutterweb/visitorBook/model/constants.dart';
import 'package:flutterweb/visitorBook/model/note.dart';

class VisitorBookViewController extends GetxService{
  RxList<Note> notes = <Note>[].obs;
//  RxList<Note> notes = tempList.obs;

  void addNote(Note newNote){
    notes.add(newNote);
  }

  void updateNotes (List<Note> newNotes) {
    notes(newNotes);
  }

  void getNotes(){
    getNotesFromFirebase();
  }

  Future<int> postNote(String title, String content){
    return postNoteToFirebase(title, content);
  }
}