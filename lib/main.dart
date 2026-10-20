import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/dependency_injection/injection.dart';
import 'package:news_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:news_app/features/home/presentation/pages/home_page.dart';
import 'package:news_app/features/news/presentation/cubit/news_cubit.dart';

void main() {
  configureDependencies();
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Newsroom',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE95440),
          brightness: Brightness.light,
          surface: const Color(0xFFF8F6F1),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F6F1),
        fontFamily: 'sans-serif',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF8F6F1),
          surfaceTintColor: Colors.transparent,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: const Color(0xFFFFDDD7),
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<NewsCubit>()..loadNews()),
          BlocProvider(create: (_) => getIt<FavoritesCubit>()..loadFavorites()),
        ],
        child: const HomePage(),
      ),
    );
  }
}
