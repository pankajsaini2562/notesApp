import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/models/note.dart';
import '../providers/note_provider.dart';

class NoteScreen extends ConsumerStatefulWidget {
  const NoteScreen({super.key});

  @override
  ConsumerState<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends ConsumerState<NoteScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final notes = ref.watch(noteProvider);
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 17),
          Container(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Plz enter ther text',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(noteProvider.notifier)
                        .addNote(title: _controller.text);

                    _controller.clear();
                  },
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(12),

                  child: ListTile(
                    title: Text(notes[index].title),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            showEditDialog(context, ref, notes[index]);
                          },
                          icon: Icon(Icons.edit),
                          color: Colors.green,
                        ),
                        IconButton(
                          onPressed: () {
                            ref
                                .read(noteProvider.notifier)
                                .deleteNote(notes[index].id);
                          },
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void showEditDialog(BuildContext context, WidgetRef ref, Note note) {
    final TextEditingController _controller = TextEditingController(
      text: note.title,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Note'),

          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: "Enter text here",
              border: OutlineInputBorder(),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(noteProvider.notifier)
                    .updateNote(note.id, _controller.text);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
