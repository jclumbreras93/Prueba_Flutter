import 'package:flutter/material.dart';
import 'package:prueba_bebabum/src/pages/home_page.dart';
import 'package:prueba_bebabum/src/pages/personaje_detalle.dart';
 
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