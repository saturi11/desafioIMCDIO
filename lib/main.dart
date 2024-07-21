import 'package:calcimc/pessoa.dart';
import 'package:calcimc/read.dart';

void main() {
  Pessoa pessoa = lerDados();
  double imc = pessoa.calcularIMC();
  print('${pessoa.nome}, seu IMC é ${imc.toStringAsFixed(2)}');

  if (imc < 18.5) {
    print('Você está abaixo do peso.');
  } else if (imc >= 18.5 && imc < 24.9) {
    print('Você está com peso normal.');
  } else if (imc >= 25 && imc < 29.9) {
    print('Você está com sobrepeso.');
  } else {
    print('Você está com obesidade.');
  }
}
