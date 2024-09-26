import 'package:flutter/material.dart';
import 'package:notepad/model/notes.dart';
import 'package:notepad/provider/notes_provider.dart';
import 'package:provider/provider.dart';

class NoteDetailScreen extends StatefulWidget {
  final NotesModel note;
  const NoteDetailScreen(
      {super.key, required this.note});

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  final ValueNotifier<bool> _isEdit = ValueNotifier<bool>(false);
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late Color noteColor;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    descriptionController = TextEditingController(text: widget.note.description);
    noteColor = Color(int.parse(widget.note.color, radix: 16));
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notesProvider= Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder(
          valueListenable: _isEdit,
          builder: (context, value, child) {
            return _isEdit.value
                ? TextField(
                    controller: titleController,
              style: const TextStyle(fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
                  )
                : Text(widget.note.title,style: const TextStyle(fontWeight: FontWeight.bold),);
          },
        ),
        centerTitle: true,
        actions: [
          ValueListenableBuilder(
            valueListenable: _isEdit,
            builder: (context, value, child) {
              return IconButton(
                onPressed: () {
                  if (_isEdit.value) {
                    notesProvider.updateNote( NotesModel(
                        id: widget.note.id,
                        title: titleController.text,
                        description: descriptionController.text,
                        color: noteColor.value.toRadixString(16)));
                  }
                  _isEdit.value = !_isEdit.value;
                },
                icon: Icon(_isEdit.value ? Icons.check : Icons.edit),
              );
            },
          )
        ],
        backgroundColor: noteColor,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ValueListenableBuilder(
            valueListenable: _isEdit,
            builder: (context, value, child) {
              return _isEdit.value
                  ? TextField(
                      controller: descriptionController,
                      maxLines: null,
                decoration:const InputDecoration(border: InputBorder.none),
                    )
                  : Text(
                      widget.note.description,
                      style: const TextStyle(fontSize: 18,),
                    );
            },
          )),
    );
  }
}
