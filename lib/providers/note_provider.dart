import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../models/note.dart';

class NoteNotifier extends StateNotifier<List<Note>> {
  late Box<Note> _box;
  NoteNotifier() : super([]) {
    _box = Hive.box<Note>('notesBox');
    state = _box.values.toList(); // Load saved notes on startup
  }

  //addNote
  void addNote({required String title}) {
    final note = Note(
      description: '',
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      tags: [],
    );
    _box.put(note.id, note);
    state = [...state, note];
  }

  //deleteNote
  void deleteNote(String id) {
    _box.delete(id);
    state = state.where((note) => note.id != id).toList();
  }

  //updatenote
  void updateNote(String id, String newTitle) {
    final note = _box.get(id);
    if (note != null) {
      final updated = note.copyWith(title: newTitle);
      _box.put(id, updated);
      state = state.map((n) => n.id == id ? updated : n).toList();
    }
  }
}

final noteProvider = StateNotifierProvider<NoteNotifier, List<Note>>((ref) {
  return NoteNotifier();
});
