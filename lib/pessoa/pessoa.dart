class Pessoa {
  double peso;
  double altura;
  int genero;

  Pessoa({
    this.peso,
    this.altura,
    this.genero = 0,
  });

  double get getPeso => peso;
  double get getAltura => altura;
  int get getGenero => genero;

  set setPeso(double peso) {
    this.peso = peso;
  }

  set setAltura(double altura) {
    this.altura = altura;
  }

  set setGenero(int genero) {
    this.genero = genero;
  }
}
