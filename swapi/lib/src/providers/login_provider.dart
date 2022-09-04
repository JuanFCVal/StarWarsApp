import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:swapi/src/models/character.dart';

import 'package:swapi/src/models/film.dart';

class LoginProvider extends ChangeNotifier {
  final String baseUrl = "https://swapi.dev/api";
  List<Character> characters = [];
  bool _loading = false;
  late List<Film> films = [];
  late Film selectedFilm;
  late Character logedCharacter;
  List<Character> movieCharacters = [];
  bool fade = true;
  setSelectedFilm(Film film) {
    selectedFilm = film;
  }

  set Fade(value) {
    fade = value;
    notifyListeners();
  }

  setCharacters(characterResponse) {
    characters.addAll(characterResponse.characters!);
  }

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get isLoading => _loading;

  getCharactersForLogin() async {
    final url = Uri.parse('$baseUrl/people/');
    final resp = await http.get(url);
    final characterResponse = charactersFromJson(resp.body);
    setCharacters(characterResponse);
  }

  Future<bool> validateLogin(String user, String password) async {
    setLoading(true);
    bool valid = false;
    if (characters.isEmpty) {
      await getCharactersForLogin();
    }
    characters.forEach((character) {
      if (user == character.name && password == character.hairColor) {
        logedCharacter = character;
        valid = true;
      }
    });
    setLoading(false);
    return valid;
  }

  addFilm(Film film) {
    films.add(film);
    notifyListeners();
  }

  addCharacter(Character character) {
    movieCharacters.add(character);
    notifyListeners();
  }

  getFilms() async {
    setLoading(true);
    try {
      print("Looking for films");
      logedCharacter.films!.forEach((element) async {
        final url = Uri.parse('$element');
        print(url);
        final resp = await http.get(url);
        final film = filmFromJson(resp.body);
        addFilm(film);
      });
      setLoading(false);
    } catch (error) {
      debugPrint("Error while loading films");
    }
  }

  getCharactersFromFilm() async {
    setLoading(true);

    try {
      print(selectedFilm.characters!.length);
      for (final character in selectedFilm.characters!) {
        Fade = false;
        final url = Uri.parse('$character');
        debugPrint(character);
        final resp = await http.get(url);
        debugPrint(resp.body);
        Character auxCharacter = characterFromJson(resp.body);
        debugPrint(auxCharacter.name);
        addCharacter(auxCharacter);
        Fade = true;
      }
    } catch (error) {
      debugPrint("Error while loading characters");
    }
    setLoading(false);
  }
}
