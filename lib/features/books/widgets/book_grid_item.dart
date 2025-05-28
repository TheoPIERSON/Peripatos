import 'package:flutter/material.dart';
import 'package:peripatos/utils/book_color.dart';
import '../models/book.dart';

class BookGridItem extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  const BookGridItem({super.key, required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: BookColors.getGenreColor(book.genre),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(20),
          constraints: const BoxConstraints(maxWidth: 200, maxHeight: 300),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _BookInfo(book: book),
              if (book.rating != null) _BookRating(rating: book.rating!),
            ],
          ),
        ),
      ),
    );
  }
}

class _BookInfo extends StatelessWidget {
  final Book book;

  const _BookInfo({required this.book});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          book.title,
          style: const TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.w700,
            fontSize: 20.0,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Text(
          book.author,
          style: const TextStyle(
            fontFamily: 'Jost',
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _BookRating extends StatelessWidget {
  final String rating;

  const _BookRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.star, color: Colors.white70, size: 16),
        const SizedBox(width: 4),
        Text(
          rating,
          style: const TextStyle(
            fontFamily: 'Jost',
            fontSize: 14.0,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
