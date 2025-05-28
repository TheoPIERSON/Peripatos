import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/book.dart';
import '../services/book_service.dart';

class BookNotifier extends StateNotifier<List<Book>> {
  final BookService _bookService;

  BookNotifier(this._bookService) : super([]);

  Future<void> loadBooks() async {
    final books = await _bookService.getBooks();
    state = books;
  }

  Future<void> createBook(Map<String, dynamic> data) async {
    final book = await _bookService.createBook(data);
    state = [...state, book];
  }

  Future<void> updateBook(String id, Map<String, dynamic> data) async {
    final updatedBook = await _bookService.updateBook(id, data);
    state = [
      for (final book in state)
        if (book.id == id) updatedBook
        else book
    ];
  }

  Future<void> deleteBook(String id) async {
    await _bookService.deleteBook(id);
    state = state.where((book) => book.id != id).toList();
  }
}

final booksProvider = StateNotifierProvider<BookNotifier, List<Book>>((ref) {
  return BookNotifier(BookService());
});
