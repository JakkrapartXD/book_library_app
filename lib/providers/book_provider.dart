import 'package:flutter/foundation.dart';
import '../models/book.dart';
import '../services/database_helper.dart';

class BookProvider with ChangeNotifier {
  List<Book> _books = [];
  List<Book> _filteredBooks = [];
  String _searchQuery = '';
  String _filterCategory = '';
  String _filterStatus = '';

  List<Book> get books => _books;
  List<Book> get filteredBooks =>
      _filteredBooks.isNotEmpty ? _filteredBooks : _books;
  String get searchQuery => _searchQuery;
  String get filterCategory => _filterCategory;
  String get filterStatus => _filterStatus;

  Future<void> fetchBooks() async {
    _books = await DatabaseHelper.instance.getAllBooks();
    applyFilters();
    notifyListeners();
  }

  Future<void> addBook(Book book) async {
    final id = await DatabaseHelper.instance.insertBook(book);
    final newBook = book.copyWith(id: id);
    _books.insert(0, newBook);
    applyFilters();
    notifyListeners();
  }

  Future<void> updateBook(Book book) async {
    await DatabaseHelper.instance.updateBook(book);
    final index = _books.indexWhere((b) => b.id == book.id);
    if (index != -1) {
      _books[index] = book;
      applyFilters();
      notifyListeners();
    }
  }

  Future<void> deleteBook(int id) async {
    await DatabaseHelper.instance.deleteBook(id);
    _books.removeWhere((book) => book.id == id);
    applyFilters();
    notifyListeners();
  }

  void searchBooks(String query) {
    _searchQuery = query;
    applyFilters();
    notifyListeners();
  }

  void filterByCategory(String category) {
    _filterCategory = category;
    applyFilters();
    notifyListeners();
  }

  void filterByStatus(String status) {
    _filterStatus = status;
    applyFilters();
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _filterCategory = '';
    _filterStatus = '';
    _filteredBooks = [];
    notifyListeners();
  }

  void applyFilters() {
    _filteredBooks = _books;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      _filteredBooks =
          _filteredBooks
              .where(
                (book) =>
                    book.title.toLowerCase().contains(
                      _searchQuery.toLowerCase(),
                    ) ||
                    book.author.toLowerCase().contains(
                      _searchQuery.toLowerCase(),
                    ),
              )
              .toList();
    }

    // Apply category filter
    if (_filterCategory.isNotEmpty) {
      _filteredBooks =
          _filteredBooks
              .where((book) => book.category == _filterCategory)
              .toList();
    }

    // Apply status filter
    if (_filterStatus.isNotEmpty) {
      _filteredBooks =
          _filteredBooks
              .where((book) => book.readingStatus == _filterStatus)
              .toList();
    }
  }
}
