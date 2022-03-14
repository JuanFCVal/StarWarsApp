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
        body: loginProvider.films.isEmpty
            ? LoadingBackground()
            : FilmsList(loginProvider.films));
  }

  Widget FilmsList(List<Film> films) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: true);
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    loginProvider.logedCharacter.name ?? "",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    loginProvider.logedCharacter.created
                            ?.toIso8601String()
                            .substring(0, 10) ??
                        "",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
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
    return ListView.builder(
      itemCount: films!.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            MovieCard(index),
            SizedBox(
              height: 40,
            ),
          ],
        );
      },
    );
  }

  Container MovieCard(int index) {
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
                        image: NetworkImage(
                            'https://www.lavanguardia.com/files/image_948_465/uploads/2020/05/04/5fa922920d3b5.png'))),
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
                "Fugiat minim adipisicing eiusmod exercitation ex est id consequat ullamco sit ipsum duis. Lorem exercitation cupidatat esse deserunt incididunt fugiat in voluptate mollit labore in cillum. Mollit consectetur ullamco reprehenderit proident reprehenderit nulla sunt qui quis tempor nostrud excepteur. Ipsum aute eiusmod amet dolore. idatat ut voluptate ipsum et. Ipsum et nulla est id ullamco nostrud...",
                style: TextStyle(color: Colors.white60),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
