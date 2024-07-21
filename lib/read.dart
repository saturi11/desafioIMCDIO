import 'dart:io';

import 'package:calcimc/pessoa.dart';

Pessoa lerDados() {
  print('Digite seu nome:');
  String nome = stdin.readLineSync()!;

  print('Digite seu peso (kg):');
  double peso;
  while (true) {
    try {
      peso = double.parse(stdin.readLineSync()!);
      break;
    } catch (e) {
      print('Valor inválido. Digite um número para o peso:');
    }
  }

  print('Digite sua altura (m):');
  double altura;
  while (true) {
    try {
      altura = double.parse(stdin.readLineSync()!);
      break;
    } catch (e) {
      print('Valor inválido. Digite um número para a altura:');
    }
  }

  return Pessoa(nome: nome, peso: peso, altura: altura);
}
