import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _infoText = 'Informe seus dados!';
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetField() {
    heightController.text = "";
    weightController.text = "";
    setState(() {
      _infoText = 'Informe seus dados!!';
      _formKey = GlobalKey<FormState>(); // ADICIONE ESTA LINHA!
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
        _infoText = ' Peso Ideal (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = ' levemente acima do peso (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = ' Acima do peso (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = 'Obesidade grau 1 (${imc.toStringAsPrecision(3)})';
      } else if (imc >= 40) {
        _infoText = 'Obesidade grau 2 (${imc.toStringAsPrecision(3)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora IMC'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: _resetField,
            icon: Icon(Icons.refresh_outlined),
            color: Colors.white,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.person_2_outlined, size: 120, color: Colors.blue),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide()),
                    // enabledBorder: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(8),
                    //   borderSide: BorderSide(
                    //     color: Colors.blue,
                    //     width: 2,
                    //   ),
                    // ),
                    labelText: 'Peso (kg)',
                    labelStyle: TextStyle(color: Colors.blue),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                  controller: weightController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "insert your Weight";
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide()),
                        // enabledBorder: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(8),
                        //   borderSide: BorderSide(
                        //     color: Colors.blue,
                        //     width: 2,
                        //   ),
                        // ),
                        labelText: 'Height (cm)',
                        labelStyle: TextStyle(color: Colors.grey)),
                    controller: heightController,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "insert your Height";
                      }
                    },
                  ),
                ),
                Container(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calculate();
                      }
                    },
                    child: Text(
                      'Calcular',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shadowColor: Colors.lightBlue,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 40),
                  child: Text(
                    _infoText!,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
