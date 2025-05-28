import 'package:flutter/material.dart';

class BookEmptyState extends StatelessWidget {
  final String message;
  final IconData? icon;

  const BookEmptyState({super.key, required this.message, this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
          ],
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontFamily: 'Jost',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
