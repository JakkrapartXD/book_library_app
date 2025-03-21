import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';
import '../widgets/book_list.dart';
import '../widgets/search_bar.dart';
import '../widgets/filter_buttons.dart';
import 'add_book_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load books when the app starts
    Future.microtask(
      () => Provider.of<BookProvider>(context, listen: false).fetchBooks(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Library'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              Provider.of<BookProvider>(context, listen: false).fetchBooks();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          CustomSearchBar(),
          FilterButtons(),
          Expanded(child: BookList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBookScreen()),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'Add a new book',
      ),
    );
  }
}
