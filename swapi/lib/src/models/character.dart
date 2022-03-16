// To parse this JSON data, do
//
//     final character = characterFromJson(jsonString);

import 'dart:convert';

import 'dart:math';

Character characterFromJson(String str) => Character.fromJson(json.decode(str));
Characters charactersFromJson(String str) =>
    Characters.fromJson(json.decode(str));

String characterToJson(Character data) => json.encode(data.toJson());

class Characters {
  List<Character>? characters;
  int? totalResults;
  Characters({this.characters, this.totalResults});

  factory Characters.fromJson(Map<String, dynamic> json) => Characters(
        totalResults: json["count"],
        characters: List<Character>.from(
            json["results"].map((x) => Character.fromJson(x))),
      );
}

class Character {
  Character({
    this.name,
    this.height,
    this.mass,
    this.hairColor,
    this.skinColor,
    this.eyeColor,
    this.birthYear,
    this.gender,
    this.homeworld,
    this.films,
    this.species,
    this.vehicles,
    this.starships,
    this.created,
    this.edited,
    this.url,
  });

  String? name;
  String? height;
  String? mass;
  String? hairColor;
  String? skinColor;
  String? eyeColor;
  String? birthYear;
  String? gender;
  String? homeworld;
  List<String>? films;
  List<String>? species;
  List<String>? vehicles;
  List<String>? starships;
  DateTime? created;
  DateTime? edited;
  String? url;
  String? backgroundImage = "";

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        name: json["name"],
        height: json["height"],
        mass: json["mass"],
        hairColor: json["hair_color"],
        skinColor: json["skin_color"],
        eyeColor: json["eye_color"],
        birthYear: json["birth_year"],
        gender: json["gender"],
        homeworld: json["homeworld"],
        films: List<String>.from(json["films"].map((x) => x)),
        species: List<String>.from(json["species"].map((x) => x)),
        vehicles: List<String>.from(json["vehicles"].map((x) => x)),
        starships: List<String>.from(json["starships"].map((x) => x)),
        created: DateTime.parse(json["created"]),
        edited: DateTime.parse(json["edited"]),
        url: json["url"],
      );

  get BackgroundIamge {
    List<String> imageArray = [
      "https://media.gq.com.mx/photos/5dfbaf25d811050008602c46/16:9/w_1280,c_limit/star%20wars.jpg",
      "https://www.filo.news/__export/1576701773136/sites/claro/img/2019/12/18/0_6.jpg_1902800913.jpg",
      "https://elcomercio.pe/resizer/CCzKYeli5rmsCSECl_r9VfrE8s4=/980x0/smart/filters:format(jpeg):quality(75)/arc-anglerfish-arc2-prod-elcomercio.s3.amazonaws.com/public/7IN5YML5RRFNBKOV2T3UVJ6VLI.jpg",
      "https://pm1.narvii.com/6211/943cf27fa773d5da8addbabc3a0c27476cd6a255_hq.jpg",
      "https://imagenes.20minutos.es/files/image_656_370/uploads/imagenes/2016/01/27/maz-kanata.jpg",
      "https://www.mundopeliculas.tv/wp-content/uploads/2019/11/ImagenDestacada-MundoPeliculas-StarWars-ElAscensoDeSkywalker-02.jpg",
      "https://img.ecartelera.com/noticias/fotos/58700/58798/1.jpg",
      "https://sm.ign.com/ign_es/screenshot/default/obiwan_us81.jpg",
      "https://st1.uvnimg.com/dims4/default/258b41e/2147483647/thumbnail/480x270/quality/75/?url=https%3A%2F%2Fuvn-brightspot.s3.amazonaws.com%2Fassets%2Fvixes%2Fbtg%2Fcine.batanga.com%2Ffiles%2Fpersonajes-de-star-wars-4.jpeg",
      "https://imagenes.20minutos.es/files/og_thumbnail/uploads/imagenes/2020/05/04/mace-windu.jpg",
      "https://cdn-e360.s3-sa-east-1.amazonaws.com/cms_jabbajpg__Nlisk531dxYsUohxJAehuH6WeZrGlOCRGwMNaRMy.jpeg",
      "https://img.europapress.es/fotoweb/fotonoticia_20140221115318-545299_480.jpg"
    ];
    if (backgroundImage == "") {
      final _random = new Random();
      backgroundImage = imageArray[_random.nextInt(imageArray.length)];
    }
    return backgroundImage;
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "height": height,
        "mass": mass,
        "hair_color": hairColor,
        "skin_color": skinColor,
        "eye_color": eyeColor,
        "birth_year": birthYear,
        "gender": gender,
        "homeworld": homeworld,
        "films": List<dynamic>.from(films!.map((x) => x)),
        "species": List<dynamic>.from(species!.map((x) => x)),
        "vehicles": List<dynamic>.from(vehicles!.map((x) => x)),
        "starships": List<dynamic>.from(starships!.map((x) => x)),
        "created": created!.toIso8601String(),
        "edited": edited!.toIso8601String(),
        "url": url,
      };
}
