import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:swapi_prueba_flutter/src/models/peliculas_model.dart';
import 'package:swapi_prueba_flutter/src/models/personaje_model.dart';



class PersonajesProvider {

  //URL API
  final _url = 'swapi.dev';

  int _page = 0;

  List<Personaje> _pers = new List();

  final _stream = StreamController<List<Personaje>>.broadcast();

  //Sink y Stream para traer los personajes, aunque se actualize la api añadiendo datos
  Function(List<Personaje>) get personajesSink => _stream.sink.add;

  Stream<List<Personaje>> get personajesStream => _stream.stream;


  void disposeStreams() { 
    _stream?.close();
  }


  Future<List<Personaje>> getPersonajes() async{

    _page++;
    //Llamada a la API pasandole la url y la pagina por parametro
    final url = Uri.https(_url, '/api/people/', {
      'page' : _page.toString()
    });


    final response = await http.get(  
      Uri.encodeFull(url.toString()),
      headers: {'Accept': 'application/json'}
    );

    //Parseo para convertir a Json
    final convertDataToJson = jsonDecode(response.body);

    final personajes = new Personajes.fromJsonList(convertDataToJson['results']);
    //Lista de los personajes obtenidos en la llamada
    final resp = personajes.items;

    _pers.addAll(resp);

    personajesSink( _pers );

    return resp;

  }

  Future<List<Pelicula>> getPeliculas() async{

    //Llamada para traer todas las peliculas
    final url = Uri.https(_url, '/api/films/', {
      
    });

    final response = await http.get(  
      Uri.encodeFull(url.toString()),
      headers: {'Accept': 'application/json'}
    );

    final convertDataToJson = jsonDecode(response.body);
  
    final cast = new CastPeliculas.fromJsonList(convertDataToJson['results']);

    return cast.peliculas;

  }
  
}