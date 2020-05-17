
import 'package:flutter/material.dart';
import 'package:prueba_bebabum/src/models/personaje_model.dart';

class CardL extends StatelessWidget {
  /*Creacion de un Widget personalizado para la creacion de las
  tarjetas de la home page
  */

  final List<Personaje> personajes;
  final Function siguientePagina;

  CardL({ @required this.personajes, @required this.siguientePagina });

  final _pageController = new PageController(initialPage: 2, viewportFraction: 0.18,);

  @override
  Widget build(BuildContext context) {

    //Medida de la pantalla
    final _screenSize = MediaQuery.of(context).size;
    //Listener del controlador
    _pageController.addListener(() {
      //Si llega al final de la pagina carga siguientes personajes
      if (_pageController.position.pixels == _pageController.position.maxScrollExtent) {      
        siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height*0.8,
      child: PageView(
        pageSnapping: false,
        controller: _pageController,
        scrollDirection: Axis.vertical,
        //Creacion de las tarjetas en forma de lista de personajes
        children: _tarjetas(context),
      ),
    );
    
  }

  List<Widget> _tarjetas(BuildContext context) {

    //Mapa para obtencion de datos de los personajes
    return personajes.map((personaje){
      return Container(
        padding: EdgeInsets.only(top: 15.0),
        child: Column(
          children: <Widget>[
            Hero(
              //Tag para animacion cuando se pasa a detalles del personaje
              tag: personaje.name,
              child: Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0) ),
              child: ListTile(
                title: Text('Nombre: ${personaje.name}'),
                subtitle: Text('Altura: ${personaje.height} cm'),
                trailing: Text(personaje.gender),
                leading: Icon(Icons.bug_report),
                onTap: (){
                  //Pasar a la pantalla de detalle con los datos del personaje
                  Navigator.pushNamed(context, 'detalle', arguments: personaje);
                },
                ),
              ),
            )
          ],
        ),
      );
    }).toList();
  }
}
