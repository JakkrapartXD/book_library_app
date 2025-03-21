class Constants {
  // Book Categories
  static const List<String> bookCategories = [
    'Fiction',
    'Non-Fiction',
    'Academic',
    'Biography',
    'History',
    'Science',
    'Philosophy',
    'Self-Help',
    'Reference',
    'Other',
  ];

  // Reading Status
  static const List<String> readingStatuses = [
    'Not Started',
    'Reading',
    'Finished',
  ];

  // Status Colors
  static const Map<String, int> statusColors = {
    'Not Started': 0xFFBDBDBD,
    'Reading': 0xFFFFA726,
    'Finished': 0xFF66BB6A,
  };
}
