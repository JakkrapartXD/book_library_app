import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/book_provider.dart';
import '../utils/constants.dart';
import 'add_book_screen.dart';

class BookDetailsScreen extends StatelessWidget {
  final Book book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final statusColor = Color(
      Constants.statusColors[book.readingStatus] ?? 0xFFBDBDBD,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookScreen(book: book),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _showDeleteConfirmationDialog(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(
                  Icons.book,
                  size: 100,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                book.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'By ${book.author}',
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildInfoChip(
                    label: book.category,
                    icon: Icons.category,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 8),
                  _buildInfoChip(
                    label: book.readingStatus,
                    icon: _getStatusIcon(book.readingStatus),
                    color: statusColor,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (book.notes != null && book.notes!.isNotEmpty) ...[
                const Text(
                  'Notes:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    book.notes!,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              Text(
                'Added on: ${_formatDate(book.dateAdded)}',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 32),
              _buildStatusUpdateButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color.withOpacity(0.8),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Not Started':
        return Icons.book_outlined;
      case 'Reading':
        return Icons.auto_stories;
      case 'Finished':
        return Icons.task_alt;
      default:
        return Icons.book;
    }
  }

  Widget _buildStatusUpdateButton(BuildContext context) {
    // Skip if the book is already finished
    if (book.readingStatus == 'Finished') {
      return const SizedBox.shrink();
    }

    final nextStatus =
        book.readingStatus == 'Not Started' ? 'Reading' : 'Finished';
    final statusColor = Color(Constants.statusColors[nextStatus] ?? 0xFFBDBDBD);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(_getStatusIcon(nextStatus)),
        label: Text('Mark as $nextStatus'),
        style: ElevatedButton.styleFrom(
          backgroundColor: statusColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: () {
          _updateReadingStatus(context, nextStatus);
        },
      ),
    );
  }

  void _updateReadingStatus(BuildContext context, String newStatus) {
    final updatedBook = book.copyWith(readingStatus: newStatus);
    Provider.of<BookProvider>(context, listen: false).updateBook(updatedBook);
    Navigator.pop(context);
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Book'),
            content: Text('Are you sure you want to delete "${book.title}"?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Provider.of<BookProvider>(
                    context,
                    listen: false,
                  ).deleteBook(book.id!);
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Go back to home screen
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
