import 'package:flutter/material.dart';
import 'package:movie_app/pages/home/home_page.dart';
import 'package:movie_app/pages/search/search_page.dart';
import 'package:movie_app/pages/top_rated/top_rated_page.dart';
import 'package:movie_app/pages/top_rated/series_page.dart';
import 'package:movie_app/pages/top_rated/movies_page.dart'; // Nova página de filmes

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int paginaAtual = 0;
  PageController pc = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Alterado para 5 páginas
      child: Scaffold(
        body: PageView(
          controller: pc,
          onPageChanged: (page) {
            setState(() {
              paginaAtual = page;
            });
          },
          children: const [
            HomePage(),
            MoviesPage(), // Nova página de filmes
            SearchPage(),
            SeriesPage(),
            TopRatedPage(), // Página de Séries
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: paginaAtual,
          iconSize: 30,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          backgroundColor: Colors.black,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Filmes'), // Botão de Filmes
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'Series'),
            BottomNavigationBarItem(icon: Icon(Icons.trending_up), label: 'Top Rated'),
          ],
          onTap: (pagina) {
            pc.animateToPage(
              pagina,
              duration: const Duration(milliseconds: 400),
              curve: Curves.ease,
            );
          },
        ),
      ),
    );
  }
}
