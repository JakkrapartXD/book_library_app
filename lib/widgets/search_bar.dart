import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    _searchController.text = bookProvider.searchQuery;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          labelText: 'Search books',
          hintText: 'Enter title or author',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              bookProvider.searchBooks('');
            },
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        onChanged: (value) {
          bookProvider.searchBooks(value);
        },
      ),
    );
  }
}
