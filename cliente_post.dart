import 'dart:convert';
import 'dart:io';
void main() async{
    stdout.write('Nombre:');
    final nombre = stdin.readLineSync();
    stdout.write('Edad:');
    final edad = int.parse(stdin.readLineSync()!);
    final cliente = HttpClient();
    final request = await cliente.postUrl(Uri.parse('http://localhost:8080/usuarios'));
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode({'nombre': nombre, 'edad': edad}));

    final response = await request.close();
    final body = await response.transform(utf8.decoder).join();

    print('Status: ${response.statusCode}');
    print('Respuesta: $body');
    cliente.close();

}