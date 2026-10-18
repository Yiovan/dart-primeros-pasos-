import 'dart:convert';
import 'dart:io';

final List<Map<String, dynamic>> usuarios = [
  {'id': 1, 'nombre': 'Ana', 'edad': 19},
  {'id': 2, 'nombre': 'Luis', 'edad': 90},
];

void main() async {
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);
  print('API escuchando en http://localhost:8080');

  await for (final request in server) {
    await manejarRequest(request);
  }
}

Future<void> manejarRequest(HttpRequest request) async {
  final path = request.uri.path;
  final method = request.method;

  try {
    if (method == 'GET' && path == '/saludo') {
      responder(request, 200, {'mensaje': 'Hola desde la API en Dart'});

    } else if (method == 'GET' && path == '/usuarios') {
      responder(request, 200, {'usuarios': usuarios});

    } else if (method == 'POST' && path == '/usuarios') {
      final body = await utf8.decoder.bind(request).join();
      final datos = jsonDecode(body);
      final nuevo = {
        'id': usuarios.isEmpty ? 1 : usuarios.last['id'] + 1,
        'nombre': datos['nombre'],
        'edad': datos['edad'],
      };
      usuarios.add(nuevo);
      responder(request, 201, nuevo);

    } else {
      responder(request, 404, {'error': 'Ruta no encontrada'});
    }
  } on FormatException {
    responder(request, 400, {'error': 'JSON invalido'});
  }
}

void responder(HttpRequest request, int status, Map<String, dynamic> body) {
  request.response.statusCode = status;
  request.response.headers.contentType = ContentType.json;
  request.response.write(jsonEncode(body));
  request.response.close();
}