import 'package:flutter/material.dart';
import 'package:notepad/provider/notes_provider.dart';
import 'package:notepad/widgets/note_form.dart';
import 'package:provider/provider.dart';

import '../model/notes.dart';

class NoteFormScreen extends StatefulWidget {
  const NoteFormScreen({super.key,required this.onSave});
  final Function onSave;

  @override
  State<NoteFormScreen> createState() => _NoteFormScreenState();
}

class _NoteFormScreenState extends State<NoteFormScreen> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController =TextEditingController();
  Color selectedColor=Colors.white;

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context);
    return NoteForm(
        titleController: titleController,
        descriptionController: descriptionController,
        selectedColor: selectedColor,
        onPress: () {
          notesProvider.addNotes( NotesModel(
              title: titleController.text.toString(),
              description: descriptionController.text.toString(),
              color: selectedColor.value.toRadixString(16)),);
          Navigator.of(context).pop();
        },

      onColorChange: (color){
          selectedColor =color;
      },
        );
  }
}
