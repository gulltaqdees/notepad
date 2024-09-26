import 'package:flutter/material.dart';
import 'package:notepad/database/db_handler.dart';
import '../model/notes.dart';

class NotesProvider extends ChangeNotifier{
  final DbHelper dbHelper;
  List<NotesModel> _notesList=[];

  NotesProvider({required this.dbHelper});

  List<NotesModel> get notesList => _notesList;

  Future<void> loadNotes()async{
    _notesList=await dbHelper.getNotesList();
    notifyListeners();
  }

  Future<void> addNotes(NotesModel notesModel)async{
    await dbHelper.insert(notesModel);
   await loadNotes();
  }

  Future<void> deleteNote(int id)async{
    await dbHelper.deleteNotes(id);
    await loadNotes();
  }

  Future<void> updateNote(NotesModel notesModel,int id)async{
    await dbHelper.updateNotes(notesModel);
    await dbHelper.getNote(id);
    notifyListeners();
  }
}