import 'package:flutter/material.dart';

class BookColors {
  static Color getGenreColor(String? genre) {
    if (genre == null) return Colors.grey[300] ?? Colors.grey;

    switch (genre.toLowerCase()) {
      case 'science-fiction':
        return Colors.yellow[700] ?? Colors.yellow;
      case 'roman':
        return Colors.blue[400] ?? Colors.blue;
      case 'policier':
        return Colors.red[400] ?? Colors.red;
      case 'fantastique':
        return Colors.purple[400] ?? Colors.purple;
      case 'biographie':
        return Colors.green[400] ?? Colors.green;
      case 'essai':
        return Colors.orange[400] ?? Colors.orange;
      case 'philosophie':
        return const Color.fromARGB(255, 55, 137, 63);
      default:
        return Colors.grey[300] ?? Colors.grey;
    }
  }
}
