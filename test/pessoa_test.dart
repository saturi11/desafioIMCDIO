import 'package:calcimc/pessoa.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Teste de IMC', () {
    test('Cálculo de IMC para peso normal', () {
      final pessoa = Pessoa(nome: 'Teste', peso: 70, altura: 1.75);
      expect(pessoa.calcularIMC(), closeTo(22.86, 0.01));
    });

    test('Cálculo de IMC para sobrepeso', () {
      final pessoa = Pessoa(nome: 'Teste', peso: 90, altura: 1.75);
      expect(pessoa.calcularIMC(), closeTo(29.39, 0.01));
    });

    test('Cálculo de IMC para obesidade', () {
      final pessoa = Pessoa(nome: 'Teste', peso: 110, altura: 1.75);
      expect(pessoa.calcularIMC(), closeTo(35.92, 0.01));
    });
  });
}
