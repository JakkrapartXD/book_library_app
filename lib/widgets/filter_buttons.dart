import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';
import '../utils/constants.dart';

class FilterButtons extends StatelessWidget {
  const FilterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filters:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              if (bookProvider.filterCategory.isNotEmpty || 
                  bookProvider.filterStatus.isNotEmpty)
                TextButton(
                  onPressed: () {
                    bookProvider.clearFilters();
                  },
                  child: const Text('Clear Filters'),
                ),
            ],
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryDropdown(context, bookProvider),
                const SizedBox(width: 8),
                _buildStatusDropdown(context, bookProvider),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildCategoryDropdown(BuildContext context, BookProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButton<String>(
        hint: const Text('Category'),
        value: provider.filterCategory.isEmpty ? null : provider.filterCategory,
        underline: const SizedBox(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            provider.filterByCategory(newValue);
          }
        },
        items: [
          const DropdownMenuItem<String>(
            value: '',
            child: Text('All Categories'),
          ),
          ...Constants.bookCategories.map((category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildStatusDropdown(BuildContext context, BookProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButton<String>(
        hint: const Text('Status'),
        value: provider.filterStatus.isEmpty ? null : provider.filterStatus,
        underline: const SizedBox(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            provider.filterByStatus(newValue);
          }
        },
        items: [
          const DropdownMenuItem<String>(
            value: '',
            child: Text('All Statuses'),
          ),
          ...Constants.readingStatuses.map((status) {
            return DropdownMenuItem<String>(
              value: status,
              child: Text(status),
            );
          }).toList(),
        ],
      ),
    );
  }
}