import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prueba_flutter_bebabum/src/pages/details_page.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final url = 'https://swapi.dev/api/people/?page=';//Url api StarWars
  List data;//List dinamico donde se guardan los datos de la respuesta en Json
  int page = 0;//Variable de pagina de api a la que se llama
  bool _isLoading = false;//Booleana para saber si está cargando o no

  ScrollController _scrollController = new ScrollController();//variable para controlar el Scroll

  @override
  void initState() {
    super.initState();
    agregatePage();
    getData();
    _scrollController.addListener(() {
      //Comprobacion para fin de pantalla haciendo scroll
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        //Método para el loading al obtener los datos
        fetchData();
      }
    });
  }

   @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prueba Bebabum'),
      ),
      body: Stack(
        children: <Widget>[
          _createList(),//Metodo que crea la estructura de la lista de personajes
          _createLoading(),//Método para crear la animacion de carga
        ],
      )
    );
  }

  Widget _createList() {   
      return ListView.builder(
        controller: _scrollController,
        itemCount: data == null ? 0 : data.length,
        itemBuilder: ( BuildContext context, int index ) {
          return Container(
            child: Center(
              child: Column( 
                children: <Widget>[
                  Card(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
                    child: Column(
                      children: <Widget>[
                        /*Metodo que completa el ListTile, además de la funcionalidad onTap(), 
                          que nos lleva a una nueva pagina con algunos detalles sobre el personaje
                          en el que hemos pulsado
                        */
                        _completeList(index),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
      );
       
  }

  //Metodo donde suma la 1 para pasar a la pagina siguiente
  void agregatePage() {
    setState(() {
      page++;
    });
  }
  
  Future<Null> fetchData() async{

    
    setState(() {
      //Ponemos la variable booleana que comprueba si está cargando a true, 
      //para más poder ejecutar el metodo de animacion de carga
      _isLoading = true;

      final duration = new Duration(seconds: 8);
      //Timer de 8 segundos, para ejecutar posteriormente llamar a la funcion 
      //que llama a la obtencion de datos de api
      return new Timer( duration, callHTTP );
    });

  } 

  /*Funcion que ejecuta una animacion en el listado, suma uno a la página
    para poder pasar a la siguiente, y llama al metodo que devuelve 
    los datos de la llamada
  */
  void callHTTP() {

    _isLoading = false; 
    _scrollController.animateTo(
      _scrollController.position.pixels-40, 
      duration: Duration(milliseconds: 1000), 
      curve: Curves.fastOutSlowIn
    );

    agregatePage();
    getData();
  }

  Future<String> getData() async{
    String result;
    //Guardamos en response el endpoint completo al que vamos a hacer la llamada
    var response = await http.get(  
      Uri.encodeFull(url+page.toString()),
      headers: {'Accept': 'application/json'}
    );

    setState(() {
      //Comprobación por si falla la obtencion de los datos
      if (response.statusCode == 200) {
        /*Convertimos los datos obtenidos a Json,
          y guardamos en la List data los datos que vienen dentro de la etiqueta 'results',
          para así tener todos los datos de todos los personajes
        */
        var convertDataToJson = jsonDecode(response.body);
        data = convertDataToJson['results'];
        result = 'Success';
      } else {
        throw Exception('Failed to load post');
      }    
    });

    return result;
  }

  //Crea la anuimacion de carga
  Widget _createLoading() {
    if (_isLoading) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator()
              ],
            ),
            SizedBox(height: 15.0,)
          ],
        ); 
     } else {
       return Container();
     }
  }

   /*Metodo que completa el ListTile, además de la funcionalidad onTap(), 
    nos lleva a una nueva pagina con algunos detalles sobre el personaje
    en el que hemos pulsado
    */
  Widget _completeList(int index) {
    return ListTile(
      title: Text(data[index]['name']),
      subtitle: Text('height: '+ data[index]['height']),
      trailing: Text(data[index]['gender']),
        onTap: () {  
          //Enviamos a la siguiente pagina los datos que deseemos                  
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => DetailsPage(
                name: data[index]["name"],
                height: data[index]["height"],
                birth_year: data[index]["birth_year"],
                eye_color: data[index]["eye_color"],
                gender: data[index]["gender"],
                hair_color: data[index]["hair_color"],
                mass: data[index]["mass"],
                skin_color: data[index]["skin_color"],
              )
            )
          );
        },
    );

  }

}