import 'package:hive/hive.dart';

part 'imc.g.dart';

@HiveType(typeId: 0)
class IMC extends HiveObject {
  @HiveField(0)
  double peso;

  @HiveField(1)
  double altura;

  IMC({required this.peso, required this.altura});

  double calcularIMC() {
    return peso / (altura * altura);
  }

  String classificarIMC() {
    double imc = calcularIMC();
    if (imc < 18.5) {
      return 'Abaixo do peso';
    } else if (imc >= 18.5 && imc < 24.9) {
      return 'Peso normal';
    } else if (imc >= 25 && imc < 29.9) {
      return 'Sobrepeso';
    } else {
      return 'Obesidade';
    }
  }
}
