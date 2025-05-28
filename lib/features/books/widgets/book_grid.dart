import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peripatos/features/books/widgets/book_filter_button.dart';
import '../providers/book_provider.dart';
import '../models/book.dart';
import '../views/book_details_modal.dart';
import 'book_grid_item.dart';
import 'book_empty_state.dart';

class BookGrid extends ConsumerWidget {
  const BookGrid({super.key});

  List<Book> _filterBooks(List<Book> books, BookFilter filter) {
    switch (filter) {
      case BookFilter.all:
        return books.where((book) => book.started != 'Liste d\'envie').toList();
      case BookFilter.wishlist:
        return books.where((book) => book.started == 'Liste d\'envie').toList();
    }
  }

  String _getEmptyMessage(BookFilter filter) {
    switch (filter) {
      case BookFilter.all:
        return 'Votre bibliothèque est vide.\nAjoutez votre premier livre !';
      case BookFilter.wishlist:
        return 'Votre liste de lecture est vide.\nAjoutez des livres à lire !';
    }
  }

  IconData _getEmptyIcon(BookFilter filter) {
    switch (filter) {
      case BookFilter.all:
        return Icons.library_books;
      case BookFilter.wishlist:
        return Icons.bookmark_border;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(booksProvider);
    final filter = ref.watch(bookFilterProvider);

    final filteredBooks = _filterBooks(books, filter);

    if (filteredBooks.isEmpty) {
      return BookEmptyState(
        message: _getEmptyMessage(filter),
        icon: _getEmptyIcon(filter),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 3 / 4,
      ),
      itemCount: filteredBooks.length,
      itemBuilder: (context, index) {
        final book = filteredBooks[index];
        return BookGridItem(
          book: book,
          onTap: () => _showBookDetails(context, book),
        );
      },
    );
  }

  void _showBookDetails(BuildContext context, Book book) {
    showDialog(
      context: context,
      builder: (context) => BookDetailsModal(book: book),
    );
  }
}
