// To parse this JSON data, do
//
//     final films = filmsFromJson(jsonString);

import 'dart:convert';

import 'dart:math';

Film filmFromJson(String str) => Film.fromJson(json.decode(str));

String filmToJson(Film data) => json.encode(data.toJson());

Films filmsToJson(String str) => Films.fromJson(json.decode(str));

class Films {
  List<Film>? films;
  Films({this.films});

  factory Films.fromJson(Map<String, dynamic> json) => Films(
        films: List<Film>.from(json["results"].map((x) => Film.fromJson(x))),
      );
}

class Film {
  Film(
      {this.title,
      this.episodeId,
      this.openingCrawl,
      this.director,
      this.producer,
      this.releaseDate,
      this.characters,
      this.planets,
      this.starships,
      this.vehicles,
      this.species,
      this.created,
      this.edited,
      this.url,
      this.backgroundImage = ""});

  String? title;
  int? episodeId;
  String? openingCrawl;
  String? director;
  String? producer;
  DateTime? releaseDate;
  List<String>? characters;
  List<String>? planets;
  List<String>? starships;
  List<String>? vehicles;
  List<String>? species;
  DateTime? created;
  DateTime? edited;
  String? url;
  String? backgroundImage;

  factory Film.fromJson(Map<String, dynamic> json) => Film(
        title: json["title"],
        episodeId: json["episode_id"],
        openingCrawl: json["opening_crawl"],
        director: json["director"],
        producer: json["producer"],
        releaseDate: DateTime.parse(json["release_date"]),
        characters: List<String>.from(json["characters"].map((x) => x)),
        planets: List<String>.from(json["planets"].map((x) => x)),
        starships: List<String>.from(json["starships"].map((x) => x)),
        vehicles: List<String>.from(json["vehicles"].map((x) => x)),
        species: List<String>.from(json["species"].map((x) => x)),
        created: DateTime.parse(json["created"]),
        edited: DateTime.parse(json["edited"]),
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "episode_id": episodeId,
        "opening_crawl": openingCrawl,
        "director": director,
        "producer": producer,
        "release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "characters": List<dynamic>.from(characters!.map((x) => x)),
        "planets": List<dynamic>.from(planets!.map((x) => x)),
        "starships": List<dynamic>.from(starships!.map((x) => x)),
        "vehicles": List<dynamic>.from(vehicles!.map((x) => x)),
        "species": List<dynamic>.from(species!.map((x) => x)),
        "created": created!.toIso8601String(),
        "edited": edited!.toIso8601String(),
        "url": url,
      };

  get OpeningCrawl {
    String openingCrawilWithoutSpaces = "";
    openingCrawilWithoutSpaces = openingCrawl!.replaceAll("\r", " ");
    openingCrawilWithoutSpaces = openingCrawl!.replaceAll("\n", " ");
    return openingCrawilWithoutSpaces;
  }

  get BackgroundIamge {
    List<String> imageArray = [
      "https://i.blogs.es/2cc78a/ordenstarwars/1366_521.jpg",
      "https://i.pcmag.com/imagery/lineups/02EQzmxBV28b44npfNsg5ly-6.fit_lim.size_1200x630.v1620053617.jpg",
      "https://static1.colliderimages.com/wordpress/wp-content/uploads/2021/03/star-wars-order.png",
      "https://thetvtraveler.com/wp-content/uploads/2019/10/star-wars-rise-skywalker.jpg",
      "https://prod-ripcut-delivery.disney-plus.net/v1/variant/disney/6E188D21FC14A4650F66DEA2031EEA656ADFBC5543BB7287E085C5437DC6F236/scale?width=800&aspectRatio=1.78&format=jpeg",
      "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F6%2F2021%2F06%2F15%2Fthe-acolyte.jpg",
      "https://www.androidauthority.com/wp-content/uploads/2019/11/star-wars-episode-4.jpg"
    ];
    if (backgroundImage == "") {
      final _random = new Random();
      backgroundImage = imageArray[_random.nextInt(imageArray.length)];
    }
    return backgroundImage;
  }

  @override
  String toString() {
    String title = this.title ?? "No title provided";
    int episode_id = this.episodeId ?? -1;
    String opening_crawl = this.openingCrawl ?? "";
    return "Title: " +
        title +
        "Episode ID" +
        episode_id.toString() +
        "" +
        "Opening " +
        opening_crawl +
        "";
  }
}
