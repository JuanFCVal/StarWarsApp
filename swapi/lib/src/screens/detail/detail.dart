import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swapi/src/models/film.dart';
import 'package:swapi/src/providers/login_provider.dart';

class DetailPage extends StatefulWidget {
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      final _loginProvider = Provider.of<LoginProvider>(context, listen: false);
      _loginProvider.getCharactersFromFilm();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _loginProvider = Provider.of<LoginProvider>(context, listen: true);
    final movie = _loginProvider.selectedFilm;
    return Scaffold(
      backgroundColor: Color.fromRGBO(8, 31, 41, 1),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _appBar(movie),
            SliverList(
                delegate: SliverChildListDelegate([
              const SizedBox(
                height: 10,
              ),
              _description(movie),
              _description(movie),
              const SizedBox(
                height: 20,
              ),
              _characters()
            ])),
          ],
        ),
      ),
    );
  }

  _appBar(Film movie) {
    return SliverAppBar(
        elevation: 2.0,
        backgroundColor: Color.fromRGBO(8, 31, 41, 1),
        expandedHeight: 200,
        floating: false,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              movie.title ?? "",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                backgroundColor: Color.fromRGBO(8, 31, 41, 1),
              ),
            ),
            background: FadeInImage(
              fit: BoxFit.fitWidth,
              image: NetworkImage(movie.backgroundImage!),
              placeholder: AssetImage('assets/imperial_emblem.gif'),
            )));
  }

  _description(Film movie) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Text(
            movie.openingCrawl ?? "",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _characters() {
    final _loginProvider = Provider.of<LoginProvider>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: [
          Divider(
            color: Colors.white,
            height: 2,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Personajes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          _loginProvider.movieCharacters.isEmpty
              ? CircularProgressIndicator()
              : Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _loginProvider.movieCharacters.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: SizedBox(
                          width: 50,
                          child: CharacterCard(_loginProvider, index),
                        ),
                      );
                    },
                  ),
                ),
          _loginProvider.isLoading && _loginProvider.movieCharacters.length > 0
              ? CircularProgressIndicator()
              : Container()
        ],
      ),
    );
  }

  Widget CharacterCard(LoginProvider _loginProvider, int index) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.40,
              child: FadeInImage(
                  placeholder: const AssetImage('assets/imperial_emblem.gif'),
                  image: NetworkImage(
                      _loginProvider.movieCharacters[index].BackgroundIamge)),
            ),
          ),
        ),
        SizedBox(
          width: 30,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              _loginProvider.movieCharacters[index].name ?? "",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            Text(
              _loginProvider.movieCharacters[index].created!
                  .toIso8601String()
                  .substring(0, 10),
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            Text(
              _loginProvider.movieCharacters[index].gender ?? "",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            Text(
              _loginProvider.movieCharacters[index].height ?? "" "mts",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        )
      ],
    );
  }
}
