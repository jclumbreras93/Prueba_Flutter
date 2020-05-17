import 'package:flutter/material.dart';
import 'package:prueba_bebabum/src/models/peliculas_model.dart';
import 'package:prueba_bebabum/src/models/personaje_model.dart';
import 'package:prueba_bebabum/src/providers/personajes_provider.dart';


class PersonajeDetalle extends StatelessWidget {

  final List<Pelicula> peli = new List();
  @override
  Widget build(BuildContext context) {

    //Guardo en personaje, los datos pasados por argumento desde el home_page
    final Personaje personaje = ModalRoute.of(context).settings.arguments;
   

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppbar(personaje),
          //Similar al listView pero mejor para ordenar
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox( height: 10.0 ),
                _titulo(context, personaje),
                _crearPeliculas(personaje),
              ]
            ),
          )
        ],
      )
    );
  }

  Widget _crearAppbar(Personaje personaje) {
    //Appbar con animaciones
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      //Se mantiene visible haciendo scroll
      pinned: true,
      //Widget adaptable en el appbar
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Hero(
          //Animacion al venir desde el home page
          tag: personaje.name,
                  child: Text(
            personaje.name,
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'), 
          image: NetworkImage('https://media.metrolatam.com/2019/10/14/starwars-a8837663f40a21792f11c176544d5ffc-1200x800.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _titulo(BuildContext context,  Personaje personaje) {
    //Creacion de parte de detalles del personaje
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          //Widget que se adapta al espacio que le queda disponible
          Flexible(
            child: Column(
              children: <Widget>[
                _infoPersonaje(context, personaje),          
              ],
            )
          )
        ],
      ),
    );

  }

  Widget _crearPeliculas(Personaje personaje) {

    final personajeProvider = new PersonajesProvider();
    //Creacion de la estructura de las peliculas en las que aparece el personaje
    return FutureBuilder(
      future: personajeProvider.getPeliculas(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _crearPeliculasPage(context, personaje, snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );

  }

  Widget _crearPeliculasPage(BuildContext context, Personaje personaje, List<Pelicula> peliculas) {
    final _screenSize = MediaQuery.of(context).size;
    //Bucle para comprobar si el personaje apareció en la pelicula
    //Si apareció se añade a una lista
    for (var j = 0; j < peliculas.length; j++) {
      for (var x = 0; x < peliculas[j].characters.length; x++) {
        if(personaje.url == peliculas[j].characters[x]){     
          peli.add(peliculas[j]);
        }
      }
    }

    return SizedBox(
      height: _screenSize.height*0.97,
      child: Container(
        padding: EdgeInsets.only(bottom: 200.0),
        child: PageView(     
          children: _infoPeli(context),
          scrollDirection: Axis.vertical,
          pageSnapping: false,
          controller: PageController(
            initialPage: 2, 
            viewportFraction: 0.15,
          ),
        ),
      ),
    );

  }

   List<Widget> _infoPeli(BuildContext context) {
     //Mostramos el nombre de la pelicula en tarjetas, con accion de onTap
    return peli.map((peli){
      return Container(
        child: Column(
          children: <Widget>[
            Card(
              color: Colors.grey,
              elevation: 10.0,
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
              child: ListTile(
                title: Text(peli.title, style: TextStyle(color: Colors.white),),
                //Llamada para ver la descripcion de la pelicula
                onTap: () => _mostrarDescripcion(context, peli)
              ),
            )
          ],
        ),

      );
    }).toList();
  }

  void _mostrarDescripcion(BuildContext context, Pelicula peli) {
    /*Mostramos la descripcion de la pelicula en un AlertDialog
      Con posibilidad de cerrarlo pulsando fuera de el, o en el boton de 'OK'
    */
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text(peli.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(peli.openingCrawl),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(), 
            child: Text('OK')
            )
          ],
        );
      },
    );

  }

  Widget _infoPersonaje(BuildContext context, Personaje personaje) {
    IconData icon = Icons.adb;

    //Comprobaciond de genero para cambiar de iconos
    if (personaje.gender == 'male') {
      icon = Icons.accessibility;
    } else if (personaje.gender == 'female') {
      icon = Icons.local_florist;
    } 
    //Creacion de los detalles de los personajes
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('Genero: ', style: Theme.of(context).textTheme.subtitle1),
            Icon(icon),
            Text('\tPeso: ${personaje.mass} kg \t Tamaño: ${personaje.height} cm', style: Theme.of(context).textTheme.subtitle1, textAlign: TextAlign.start,),
          ],
        ), 
        SizedBox(height: 40.0,),
        Center(child: Text('Peliculas en las que aparece', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold), textAlign: TextAlign.start,)),
      ],
    );   
  }

  
}