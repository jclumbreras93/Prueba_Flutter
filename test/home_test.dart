import 'package:prueba_flutter_bebabum/src/pages/home_page.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

void main() {
   HomePage h = new HomePage();
  final home = h.createState();
  test("Comprobacion Carga datos primera vez", () {
    var url = home.url;
    var page = home.page;
    page++;
    final urlExpect = url+page.toString();
    http.get(  
    Uri.encodeFull(urlExpect),
      headers: {'Accept': 'application/json'}
    );
    expect(urlExpect, 'https://swapi.dev/api/people/?page=1');
  });

}