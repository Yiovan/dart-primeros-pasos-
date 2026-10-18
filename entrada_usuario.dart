import 'dart:io';

void main() {
  stdout.write('Escribe tu nombre : ');
  String? nombre = stdin.readLineSync();

  stdout.write('Escribe tu edad  ');
  int edad = int.parse(stdin.readLineSync()!);

  print('Nombre: $nombre');
  print('Edad: $edad');
}
