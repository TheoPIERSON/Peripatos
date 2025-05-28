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
          const SizedBox(width: 16),
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
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey[200],
        foregroundColor: isSelected ? Colors.white : Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(text),
    );
  }
}
