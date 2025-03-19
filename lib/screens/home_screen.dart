import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/book_provider.dart';
import '../widgets/book_list.dart';
import '../widgets/search_bar.dart';
import '../widgets/filter_buttons.dart';
import '../widgets/language_switcher.dart';
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
    Future.microtask(() => 
      Provider.of<BookProvider>(context, listen: false).fetchBooks()
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
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
          // Language switcher
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                LanguageSwitcher(),
              ],
            ),
          ),
          CustomSearchBar(),
          FilterButtons(),
          Expanded(
            child: BookList(),
          ),
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
        tooltip: l10n.addBook,
      ),
    );
  }
}
