import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/book.dart';

class BookService {
  final supabase = Supabase.instance.client;

  Future<List<Book>> getBooks() async {
    final response = await supabase
        .from('books')
        .select()
        .order('created_at', ascending: false);
    
    return (response as List).map((json) => Book.fromJson(json)).toList();
  }

  Future<Book> createBook(Map<String, dynamic> data) async {
    final response = await supabase
        .from('books')
        .insert(data)
        .select()
        .single();
    
    return Book.fromJson(response);
  }

  Future<Book> updateBook(String id, Map<String, dynamic> data) async {
    final response = await supabase
        .from('books')
        .update(data)
        .eq('id', id)
        .select()
        .single();
    
    return Book.fromJson(response);
  }

  Future<void> deleteBook(String id) async {
    await supabase
        .from('books')
        .delete()
        .eq('id', id);
  }
}
