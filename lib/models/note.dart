class Note {
  final String id;
  final String title;
  final String description;
  final List<String> tags;
  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.tags,
  });

  Note copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? tags,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      tags: tags ?? this.tags,
    );
  }
}
