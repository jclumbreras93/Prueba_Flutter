
class Personajes {

  List<Personaje> items = new List();

  Personajes();
  //Funcion para añadir los personajes a la lista de personaje
  Personajes.fromJsonList( List<dynamic> jsonList ) {
    if ( jsonList == null ) return;
    
    for (var item in jsonList) {
      final personaje = new Personaje.fromJsonMap(item);
      items.add(personaje);
    }
  }
}

class Personaje {
  String name;
  String height;
  String mass;
  String hairColor;
  String skinColor;
  String eyeColor;
  String birthYear;
  String gender;
  String homeworld;
  List<String> films;
  List<dynamic> species;
  List<dynamic> vehicles;
  List<dynamic> starships;
  String created;
  String edited;
  String url;

  Personaje({
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

  //Funcion para generar instacia de pelicula que viene del json
  Personaje.fromJsonMap( Map<String, dynamic> json ){
    name = json['name'];
    height = json['height'];
    mass = json['mass'];
    hairColor = json['hair_color'];
    skinColor = json['skin_color'];
    eyeColor = json['eye_color'];
    birthYear = json['birth_year'];
    gender = json['gender'];
    homeworld = json['homeworld'];
    films = json['films'].cast<String>();
    species = json['species'];
    vehicles = json['vehicles'];
    starships = json['starships'];
    created = json['created'];
    edited = json['edited'];
    url = json['url'];
  }

}