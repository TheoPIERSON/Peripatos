import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/book_provider.dart';

class AddBookScreen extends ConsumerStatefulWidget {
  const AddBookScreen({super.key});

  @override
  ConsumerState<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends ConsumerState<AddBookScreen> {
  final List<String> _genres = [
    'Policier/Thriller',
    'Fantastique',
    'Fantasy',
    'Science-fiction',
    'Horreur/Epouvante',
    'Romance',
    'Biographie',
    'Documentaire',
    'Sciences',
    'Histoire',
    'Cuisine',
    'Développement personnel',
  ];

  final List<String> _avancements = [
    'Liste d\'envie',
    'Pas commencé',
    'En cours',
    'Terminé',
  ];

  final List<String> _notes = ['⭐', '⭐⭐', '⭐⭐⭐', '⭐⭐⭐⭐', '⭐⭐⭐⭐⭐'];

  String? _selectedGenre;
  String? _selectedAvancement;
  String? _selectedNote;

  @override
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _genreController = TextEditingController();
  final _startedController = TextEditingController();
  final _ratingController = TextEditingController();
  final _criticController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _genreController.dispose();
    _startedController.dispose();
    _ratingController.dispose();
    _criticController.dispose();
    super.dispose();
  }

  Future<void> _addBook() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final bookNotifier = ref.read(booksProvider.notifier);
      await bookNotifier.createBook({
        'title': _titleController.text,
        'author': _authorController.text,
        'genre': _selectedGenre,
        'started': _selectedAvancement,
        'rating': _selectedNote,
        'critic': _criticController.text,
      });

      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ajouter un livre',
          style: TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.w600,
            fontSize: 24.0,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Titre',
                  labelStyle: TextStyle(
                    fontFamily: 'Jost',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un titre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(
                  labelText: 'Auteur',
                  labelStyle: TextStyle(fontFamily: 'Jost', fontSize: 16.0),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un auteur';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              DropdownButtonFormField<String>(
                value: _selectedGenre,
                decoration: const InputDecoration(
                  labelText: 'Genre',
                  labelStyle: TextStyle(fontFamily: 'Jost', fontSize: 16.0),
                  border: OutlineInputBorder(),
                ),
                items: _genres.map((String genre) {
                  return DropdownMenuItem<String>(
                    value: genre,
                    child: Text(
                      genre,
                      style: const TextStyle(
                        fontFamily: 'Jost',
                        fontSize: 16.0,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGenre = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Veuillez sélectionner un genre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              DropdownButtonFormField<String>(
                value: _selectedAvancement,
                decoration: const InputDecoration(
                  labelText: 'Avancement',
                  labelStyle: TextStyle(fontFamily: 'Jost', fontSize: 16.0),
                  border: OutlineInputBorder(),
                ),
                items: _avancements.map((String avancement) {
                  return DropdownMenuItem<String>(
                    value: avancement,
                    child: Text(
                      avancement,
                      style: const TextStyle(
                        fontFamily: 'Jost',
                        fontSize: 16.0,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedAvancement = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Veuillez sélectionner un avancement';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              DropdownButtonFormField<String>(
                value: _selectedNote,
                decoration: const InputDecoration(
                  labelText: 'Note',
                  labelStyle: TextStyle(fontFamily: 'Jost', fontSize: 16.0),
                  border: OutlineInputBorder(),
                ),
                items: _notes.map((String note) {
                  return DropdownMenuItem<String>(
                    value: note,
                    child: Text(
                      note,
                      style: const TextStyle(
                        fontFamily: 'Jost',
                        fontSize: 16.0,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedNote = newValue;
                  });
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _criticController,
                decoration: const InputDecoration(
                  labelText: 'Avis',
                  labelStyle: TextStyle(fontFamily: 'Jost', fontSize: 16.0),
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _isLoading ? null : _addBook,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text(
                        'Ajouter',
                        style: TextStyle(
                          fontFamily: 'Jost',
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
