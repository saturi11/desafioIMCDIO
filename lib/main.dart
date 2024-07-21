import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'imc.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(IMCAdapter());
  await Hive.openBox<IMC>('imcBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();

  late Box<IMC> imcBox;

  @override
  void initState() {
    super.initState();
    imcBox = Hive.box<IMC>('imcBox');
  }

  void _calcularIMC() {
    if (_formKey.currentState!.validate()) {
      double peso = double.parse(_pesoController.text);
      double altura = double.parse(_alturaController.text);

      IMC imc = IMC(peso: peso, altura: altura);

      setState(() {
        imcBox.add(imc);
      });

      _pesoController.clear();
      _alturaController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _pesoController,
                    decoration: InputDecoration(labelText: 'Peso (kg)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o peso';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Por favor, insira um número válido';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _alturaController,
                    decoration: InputDecoration(labelText: 'Altura (m)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a altura';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Por favor, insira um número válido';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _calcularIMC,
                    child: Text('Calcular IMC'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: imcBox.listenable(),
                builder: (context, Box<IMC> box, _) {
                  if (box.values.isEmpty) {
                    return Center(
                      child: Text('Nenhum cálculo de IMC registrado.'),
                    );
                  }

                  return ListView.builder(
                    itemCount: box.values.length,
                    itemBuilder: (context, index) {
                      IMC imc = box.getAt(index)!;
                      return ListTile(
                        title: Text(
                            'IMC: ${imc.calcularIMC().toStringAsFixed(2)}'),
                        subtitle: Text(imc.classificarIMC()),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
