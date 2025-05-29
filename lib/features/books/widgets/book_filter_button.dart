import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// État pour gérer le filtre des livres
enum BookFilter { all, wishlist }

final bookFilterProvider = StateProvider<BookFilter>((ref) => BookFilter.all);

class BookFilterButtons extends ConsumerWidget {
  const BookFilterButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(bookFilterProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _FilterButton(
            text: 'Bibliothèque',
            isSelected: filter == BookFilter.all,
            onPressed: () =>
                ref.read(bookFilterProvider.notifier).state = BookFilter.all,
          ),
          const SizedBox(width: 20),
          _FilterButton(
            text: 'Liste de lecture',
            isSelected: filter == BookFilter.wishlist,
            onPressed: () => ref.read(bookFilterProvider.notifier).state =
                BookFilter.wishlist,
          ),
        ],
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const _FilterButton({
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: isSelected ? Colors.blue[800]! : Colors.grey[600]!,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(0), // Coins droits
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8), // Ombre opaque et brute
            offset: const Offset(4, 4), // Décalage fixe pour effet années 2000
            blurRadius: 0, // Pas de flou pour une ombre nette
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 16,
            ), // Plus de padding
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.blue[800] : Colors.grey[700],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
