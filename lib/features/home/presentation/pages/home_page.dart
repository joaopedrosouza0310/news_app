import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:news_app/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:news_app/features/favorites/presentation/widgets/favorites_view.dart';
import 'package:news_app/features/news/presentation/widgets/news_feed.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) => Scaffold(
        body: SafeArea(
          bottom: false,
          child: IndexedStack(
            index: _selectedIndex,
            children: const [NewsFeed(), FavoritesView()],
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() => _selectedIndex = index);
          },
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              selectedIcon: Icon(Icons.explore_rounded),
              label: 'Discover',
            ),
            NavigationDestination(
              icon: Badge(
                isLabelVisible: state.favorites.isNotEmpty,
                label: Text('${state.favorites.length}'),
                child: const Icon(Icons.bookmark_border_rounded),
              ),
              selectedIcon: const Icon(Icons.bookmark_rounded),
              label: 'Saved',
            ),
          ],
        ),
      ),
    );
  }
}
