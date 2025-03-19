import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/book_provider.dart';
import '../utils/constants.dart';

class AddBookScreen extends StatefulWidget {
  final Book? book;

  const AddBookScreen({super.key, this.book});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _notesController = TextEditingController();
  String _selectedCategory = Constants.bookCategories.first;
  String _selectedStatus = Constants.readingStatuses.first;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      _isEditing = true;
      _titleController.text = widget.book!.title;
      _authorController.text = widget.book!.author;
      _selectedCategory = widget.book!.category;
      _selectedStatus = widget.book!.readingStatus;
      _notesController.text = widget.book!.notes ?? '';
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _saveBook() {
    if (_formKey.currentState!.validate()) {
      final bookProvider = Provider.of<BookProvider>(context, listen: false);

      final book = Book(
        id: widget.book?.id,
        title: _titleController.text,
        author: _authorController.text,
        category: _selectedCategory,
        readingStatus: _selectedStatus,
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
        dateAdded: widget.book?.dateAdded,
      );

      if (_isEditing) {
        bookProvider.updateBook(book);
      } else {
        bookProvider.addBook(book);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? 'Edit Book' : 'Add New Book')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _authorController,
                  decoration: const InputDecoration(
                    labelText: 'Author',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an author';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedCategory,
                  items:
                      Constants.bookCategories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Reading Status',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedStatus,
                  items:
                      Constants.readingStatuses.map((status) {
                        return DropdownMenuItem<String>(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    labelText: 'Notes (optional)',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _saveBook,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    _isEditing ? 'Update Book' : 'Add Book',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
