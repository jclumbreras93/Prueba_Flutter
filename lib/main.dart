import 'package:flutter/material.dart';
import 'package:swapi_prueba_flutter/src/pages/home_page.dart';
import 'package:swapi_prueba_flutter/src/pages/personaje_detalle.dart';

 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StarWars',
      initialRoute: '/',
      routes: {
        //Definicion de las rutas de paginas
        '/' : ( BuildContext context ) => HomePage(),
        'detalle' : ( BuildContext context ) => PersonajeDetalle(),
      },
    );
  }
}