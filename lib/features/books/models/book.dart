class Book {
  final String id;
  final String title;
  final String author;
  final String? genre;
  final String? started;
  final String? rating;
  final String? critic;
  final DateTime createdAt;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.started,
    this.rating,
    this.critic,
    required this.createdAt,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      genre: json['genre'] as String?,
      started: json['started'] as String?,
      rating: json['rating'] as String?,
      critic: json['critic'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'genre': genre,
      'started': started,
      'rating': rating,
      'critic': critic,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
