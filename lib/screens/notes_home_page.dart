import 'package:flutter/material.dart';
import 'package:notepad/provider/notes_provider.dart';
import 'package:notepad/provider/theme_provider.dart';
import 'package:notepad/screens/note_detail_screen.dart';
import 'package:provider/provider.dart';
import 'note_form_screen.dart';

class NotesHomePageScreen extends StatefulWidget {
  const NotesHomePageScreen({super.key});

  @override
  State<NotesHomePageScreen> createState() => _NotesHomePageScreenState();
}

class _NotesHomePageScreenState extends State<NotesHomePageScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NotesProvider>(context,listen: false).loadNotes();
  }


  @override
  Widget build(BuildContext context) {

    final notesProvider = Provider.of<NotesProvider>(context);
    final noteList = notesProvider.notesList;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        centerTitle: true,
        actions: [
          Switch(value: themeProvider.isDarkTheme, onChanged: (lightTheme){
            themeProvider.toggleTheme();
          })
        ],
      ),
      body: noteList.isEmpty
          ? const Center(child:  CircularProgressIndicator())
          : ListView.builder(
              itemCount: noteList.length,
              itemBuilder: (context, index) {
                final note = noteList[index];
                Color noteColor = Color(int.parse(note.color, radix: 16));
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete_forever),
                  ),
                  onDismissed: (DismissDirection direction) {
                    notesProvider.deleteNote(note.id!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${note.title} deleted'),
                        backgroundColor: Colors.amberAccent,
                      ),
                    );
                  },
                  key: ValueKey<int>(note.id!),
                  child: Card(
                    color: noteColor,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NoteDetailScreen(
                              note: note,
                            ),
                          ),
                        );
                      },
                      title: Text(note.title.toString(), style: const TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text(
                        note.description.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: Text(note.id.toString()),
                    ),
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return NoteFormScreen(
                    onSave: () => notesProvider.loadNotes());
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
