import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/auth/views/login_screen.dart';
import 'features/auth/views/register_screen.dart';
import 'features/auth/views/home_screen.dart';
import 'features/books/views/books_list.dart';
import 'features/books/views/add_book/add_book_screen.dart';
import 'features/auth/providers/auth_provider.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://vsjznulaesfeqqdgczku.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZzanpudWxhZXNmZXFxZGdjemt1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDgzMzcyNjEsImV4cCI6MjA2MzkxMzI2MX0.kP--vYo3W9o2XB11nyEruoeiECqplUQP8MD54XaTLis',
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return MaterialApp(
      title: 'Peripatos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Jost', // Définit la police par défaut
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Jost', // Police spécifique pour le titre
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontFamily: 'Jost',
            fontSize: 16.0,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Jost',
            fontSize: 14.0,
          ),
          bodySmall: TextStyle(
            fontFamily: 'Jost',
            fontSize: 12.0,
          ),
          titleLarge: TextStyle(
            fontFamily: 'Jost',
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontFamily: 'Jost',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(
            fontFamily: 'Jost',
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/books': (context) => const BooksListScreen(),
        '/add-book': (context) => const AddBookScreen(),
      },
      home: authState.when(
        data: (user) {
          if (user == null) {
            return const HomeScreen();
          }
          return const BooksListScreen();
        },
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (error, stack) =>
            Scaffold(body: Center(child: Text('Erreur: $error'))),
      ),
    );
  }
}
