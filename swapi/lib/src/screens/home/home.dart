import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swapi/src/models/character.dart';
import 'package:swapi/src/models/film.dart';
import 'package:swapi/src/providers/character_provider.dart';
import 'package:swapi/src/providers/login_provider.dart';
import 'package:swapi/src/screens/home/widgets/loading.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      final _loginProvider = Provider.of<LoginProvider>(context, listen: false);
      _loginProvider.getFilms();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: true);
    return Scaffold(
        backgroundColor: Color.fromRGBO(8, 31, 41, 1),
        appBar: loginProvider.films.isEmpty
            ? AppBar(
                backgroundColor: Color.fromRGBO(8, 31, 41, 1),
                elevation: 0,
              )
            : AppBar(
                backgroundColor: Color.fromRGBO(8, 31, 41, 1),
                elevation: 5,
                title: Text(
                  loginProvider.logedCharacter.name ?? "",
                  style: TextStyle(fontSize: 18),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.logout),
                    tooltip: 'Show Snackbar',
                    onPressed: () {},
                  ),
                ],
              ),
        body: loginProvider.films.isEmpty
            ? const LoadingBackground()
            : FilmsList(loginProvider.films));
  }

  Widget FilmsList(List<Film> films) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Movie(
                films: films,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Movie extends StatelessWidget {
  List<Film>? films;
  Movie({required this.films});
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: true);
    return ListView.builder(
      itemCount: films!.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            MovieCard(index, loginProvider, context),
            SizedBox(
              height: 40,
            ),
          ],
        );
      },
    );
  }

  Container MovieCard(int index, loginProvider, context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white10, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    films![index].director ?? "No title",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                films![index].title ?? "",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Episode: ' + films![index].episodeId.toString(),
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: Container(
                    child: FadeInImage(
                        placeholder:
                            const AssetImage('assets/imperial_emblem.gif'),
                        image: NetworkImage(films![index].BackgroundIamge))),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                films![index].producer ?? "",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                films![index].OpeningCrawl ?? "",
                style: TextStyle(color: Colors.white60),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      loginProvider.setSelectedFilm(films![index]);
                      Navigator.pushNamed(
                        context,
                        'detail',
                      );
                    },
                    child: Text("Tell me more"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
