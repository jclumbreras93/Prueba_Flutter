import 'package:flutter/material.dart';
import 'package:prueba_bebabum/src/providers/personajes_provider.dart';
import 'package:prueba_bebabum/src/widgets/card_widget.dart';

class HomePage extends StatelessWidget {

  final personajesProvider = new PersonajesProvider();

  @override
  Widget build(BuildContext context) {

    personajesProvider.getPersonajes();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Personajes StarWars'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Stack(
        children: <Widget>[
          _tarjetas(context)
        ],
      )
      
    );
  }

  Widget _tarjetas(BuildContext context) {
    /*Creacion de la estructura principal del home_page, y llamada al Widget personalizado
    de creacion de tarjetas
    */
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          StreamBuilder(
            stream: personajesProvider.personajesStream,
            builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                return CardL(
                  personajes: snapshot.data, 
                  siguientePagina: personajesProvider.getPersonajes,
                );  
              } else {
                return Center(child: CircularProgressIndicator());
              }  
            }
          )
        ],
      ),
    );

  }
}