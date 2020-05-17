class CastPeliculas {

  List<Pelicula> peliculas = new List();

  //Funcion para añadir las peliculas a la lista de pelicula
  CastPeliculas.fromJsonList( List<dynamic> jsonList){

    if (jsonList == null) return;

    jsonList.forEach((item) {

      final pelicula = Pelicula.fromJsonMap(item);
      peliculas.add(pelicula);

    });
  }
}


class Pelicula {
  String title;
  int episodeId;
  String openingCrawl;
  String director;
  String producer;
  String releaseDate;
  List<String> characters;
  List<String> planets;
  List<String> starships;
  List<String> vehicles;
  List<String> species;
  String created;
  String edited;
  String url;

  Pelicula({
    this.title,
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
  });

  //Funcion para generar instacia de pelicula que viene del json
  Pelicula.fromJsonMap( Map<String, dynamic> json ) {
   title = json['title'];
   episodeId = json['episode_id'];
   openingCrawl = json['opening_crawl'];
   director = json['director'];
   producer = json['producer'];
   releaseDate = json['release_date'];
   characters = json['characters'].cast<String>();
   planets = json['planets'].cast<String>();
   starships = json['starships'].cast<String>();
   vehicles = json['vehicles'].cast<String>();
   species = json['species'].cast<String>();
   created = json['created'];
   edited = json['edited'];
   url = json['url'];

  }
  
  //Meéodo que devuelve el titulo de la pelicula
  getTituloPeli() {

    if (title == null){
      return 'Sin Titulo';
    } else{
      return title;
    }

  }
  //Método para devolver la descripción de la pelicula
  getDescripcionPelicula(){

    if (openingCrawl == null){
      return 'Sin Descripcion';
    } else{
      return openingCrawl;
    }

  }


}
