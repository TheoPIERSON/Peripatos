import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peripatos/features/books/widgets/book_filter_button.dart';
import '../widgets/book_grid.dart';
import '../providers/book_provider.dart';

class BooksListScreen extends ConsumerWidget {
  const BooksListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Charger les livres au montage du widget
    ref.read(booksProvider.notifier).loadBooks();
    
    return Scaffold(
      appBar: _buildAppBar(context),
      body: const Column(
        children: [
          BookFilterButtons(),
          Expanded(child: BookGrid()),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
      title: const Text(
        'Peripatos',
        style: TextStyle(
          fontFamily: 'Jost',
          fontWeight: FontWeight.w700,
          fontSize: 40,
        ),
      ),
      centerTitle: false,
      titleSpacing: 25,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(25),
            ),
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => Navigator.pushNamed(context, '/add-book'),
            ),
          ),
        ),
      ],
    );
  }
}
