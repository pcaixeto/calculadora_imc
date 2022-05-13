import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Informe seus dados';

  void _resetFields() {

    weightController.text = '';
    heightController.text = '';
    setState(() {
      _infoText = 'Informe seus dados';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _infoText = 'Abaixo do Peso (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = 'Peso Ideal (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = 'Levemente Acima do Peso (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 29.6 && imc < 34.9) {
        _infoText = 'Obesidade Grau I (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 34.6 && imc < 39.9) {
        _infoText = 'Obesidade Grau II (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 40) {
        _infoText = 'Obesidade Grau III (${imc.toStringAsPrecision(3)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calculadora de IMC'),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [IconButton(onPressed: _resetFields, icon: const Icon(Icons.refresh))],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.person_outline,
                  color: Colors.green,
                  size: 120,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Peso (kg)',
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: weightController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Insira seu Peso';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Altura (cm)',
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: heightController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Insira sua altura';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0, bottom: 20.0),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()){
                          _calculate();
                        }
                      },
                      child: const Text('Calcular', style: TextStyle(fontSize: 25)),
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.green, fontSize: 25),
                ),
              ],
            ),
          )
        )
    );
  }
}
