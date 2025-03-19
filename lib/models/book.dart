class Book {
  final int? id;
  final String title;
  final String author;
  final String category;
  final String readingStatus;
  final String? notes;
  final DateTime dateAdded;

  Book({
    this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.readingStatus,
    this.notes,
    DateTime? dateAdded,
  }) : this.dateAdded = dateAdded ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'category': category,
      'readingStatus': readingStatus,
      'notes': notes,
      'dateAdded': dateAdded.toIso8601String(),
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      category: map['category'],
      readingStatus: map['readingStatus'],
      notes: map['notes'],
      dateAdded: DateTime.parse(map['dateAdded']),
    );
  }

  Book copyWith({
    int? id,
    String? title,
    String? author,
    String? category,
    String? readingStatus,
    String? notes,
    DateTime? dateAdded,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      category: category ?? this.category,
      readingStatus: readingStatus ?? this.readingStatus,
      notes: notes ?? this.notes,
      dateAdded: dateAdded ?? this.dateAdded,
    );
  }
}
