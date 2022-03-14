import 'package:flutter/material.dart';
import 'package:swapi/src/models/character.dart';
import 'package:swapi/src/models/film.dart';
import 'package:http/http.dart' as http;

class CharacterProvider with ChangeNotifier {
  final String baseUrl = "https://swapi.dev/api/ ";
  late List<Film> films;
  late Character character;
  bool _loading = true;
  CharacterProvider() {
    getFilms();
  }
  addFilm(Film film) {
    print(film.director);
    films.add(film);
  }

  set isLoading(value) {
    debugPrint("loading $value");
    _loading = value;
    notifyListeners();
  }

  bool get isLoading => _loading;

  getFilms() async {
    try {
      print("Looking for films");
      character.films!.forEach((element) async {
        final url = Uri.parse('$element');
        print(url);
        final resp = await http.get(url);
        final film = filmFromJson(resp.body);
        addFilm(film);
      });
      return films;
    } catch (error) {
      debugPrint("Error while loading films");
    }

    // ignore: prefer_typing_uninitialized_variables
  }
}
