import 'package:flutter/material.dart';

//Clase donde se construye la pagina de los detalles
class DetailsPage extends StatelessWidget {
  String name;
	String height;
	String mass;
	String hair_color;
	String skin_color;
  String eye_color;
	String birth_year;
	String gender;
  //Los parametros que se ponen en esta parte son los que se deberan pasar desde la pantalla anterior
  DetailsPage({Key key, @required this.name, this.height,this.mass,
  this.hair_color,this.skin_color,this.eye_color, this.birth_year, this.gender}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('Details Page'),
       ),
       body: ListTile(
         title: titleDetails(),
         subtitle: subtitleDetails()
       ),
    );
  }

  Widget subtitleDetails() {
    return Text(
            '\nheight: $height \n'
            'mass: $mass \n'
            'hair_color: $hair_color \n'
            'skin_color: $skin_color \n'
            'eye_color: $eye_color \n'
            'birth_year: $birth_year \n'
            'gender: $gender \n',
            style: TextStyle(fontSize: 30.0),
    );
  }

  Widget titleDetails() {
    return Text(
      name,
      style: TextStyle(
        fontWeight: FontWeight.
        bold, fontSize: 40.0
      )
    );
  }
}
