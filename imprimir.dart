void imprimirTexto(String texto) {
  print(texto);
}

void imprimirNumero(int numero) {
  print(numero);
}

void imprimirLista(List<dynamic> lista) {
  for (var elemento in lista) {
    print(elemento);
  }
}

void main() {
  imprimirTexto('Hola, esto es un texto');
  imprimirNumero(42);
  imprimirLista(['manzana', 'banana', 'cereza']);
}
