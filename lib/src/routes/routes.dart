import 'package:flutter/material.dart';
import 'package:prueba_flutter_bebabum/src/pages/home_page.dart';

//Aquí guardariamos las ruutas a las diferentes paginas de nuestra aplicacion
Map<String, WidgetBuilder> getApplicationRoutes() {

  return <String, WidgetBuilder>{
    '/' : ( BuildContext context ) => HomePage(),
  };

}