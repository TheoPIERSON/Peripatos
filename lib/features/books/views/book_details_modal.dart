import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peripatos/features/books/providers/book_provider.dart';
import 'package:peripatos/features/books/models/book.dart';

class BookDetailsModal extends ConsumerStatefulWidget {
  final Book book;

  const BookDetailsModal({super.key, required this.book});

  @override
  ConsumerState<BookDetailsModal> createState() => _BookDetailsModalState();
}

class _BookDetailsModalState extends ConsumerState<BookDetailsModal> {
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _genreController;
  late TextEditingController _ratingController;
  late TextEditingController _criticController;
  late TextEditingController _startedController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
    _authorController = TextEditingController(text: widget.book.author);
    _genreController = TextEditingController(text: widget.book.genre);
    _ratingController = TextEditingController(text: widget.book.rating);
    _criticController = TextEditingController(text: widget.book.critic);
    _startedController = TextEditingController(text: widget.book.started);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _genreController.dispose();
    _ratingController.dispose();
    _criticController.dispose();
    _startedController.dispose();
    super.dispose();
  }

  Future<void> _updateBook() async {
    final updatedBook = Book(
      id: widget.book.id,
      title: _titleController.text,
      author: _authorController.text,
      genre: _genreController.text,
      started: _startedController.text,
      rating: _ratingController.text,
      critic: _criticController.text,
      createdAt: widget.book.createdAt,
    );

    await ref
        .read(booksProvider.notifier)
        .updateBook(updatedBook.id, updatedBook.toJson());
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _deleteBook() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer le livre'),
        content: const Text('Êtes-vous sûr de vouloir supprimer ce livre ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Supprimer'),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
          ),
        ],
      ),
    );

    if (shouldDelete ?? false) {
      await ref.read(booksProvider.notifier).deleteBook(widget.book.id);
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Détails du livre'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Titre'),
            ),
            TextField(
              controller: _authorController,
              decoration: const InputDecoration(labelText: 'Auteur'),
            ),
            TextField(
              controller: _genreController,
              decoration: const InputDecoration(labelText: 'Genre'),
            ),
            TextField(
              controller: _startedController,
              decoration: const InputDecoration(
                labelText: 'Statut',
                hintText: 'Liste d\'envie, En cours, Terminé',
              ),
            ),
            TextField(
              controller: _ratingController,
              decoration: const InputDecoration(labelText: 'Note (0-5)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _criticController,
              decoration: const InputDecoration(
                labelText: 'Critique',
                hintText: 'Votre avis sur le livre...',
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _deleteBook,
          child: const Text('Supprimer'),
          style: TextButton.styleFrom(foregroundColor: Colors.red),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        TextButton(onPressed: _updateBook, child: const Text('Enregistrer')),
      ],
    );
  }
}
