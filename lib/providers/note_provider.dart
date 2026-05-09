import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/note.dart';

class NoteNotifier extends StateNotifier<List<Note>> {
  NoteNotifier() : super([]);

  //readNote
  List<Note> getAllNotes() {
    return state;
  }

  //addNote
  void addNote({required String title}) {
    final note = Note(
      description: '',
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      tags: [],
    );
    state = [...state, note];
  }

  //deleteNote
  void deleteNote(String id) {
    state = state.where((note) => note.id != id).toList();
  }

  //updatenote
  void updateNote(String id, String newtitle) {
    state = state.map((note) {
      if (note.id == id) {
        return note.copyWith(title: newtitle);
      }
      return note;
    }).toList();
  }
}

final noteProvider = StateNotifierProvider<NoteNotifier, List<Note>>((ref) {
  return NoteNotifier();
});
