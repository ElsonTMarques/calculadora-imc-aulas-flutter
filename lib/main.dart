import 'package:calculadora_imc/pessoa/pessoa.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  String _result;
  Color cor;
  Pessoa pessoa = new Pessoa();

  @override
  void initState() {
    super.initState();
    resetFields();
  }

  void resetFields() {
    _weightController.text = '';
    _heightController.text = '';
    pessoa.altura = 0.0;
    pessoa.peso = 0.0;
    setState(() {
      _result = 'Informe seus dados';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0), child: buildForm()));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Calculadora de IMC'),
      backgroundColor: Colors.blue,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            resetFields();
          },
        )
      ],
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildTextFormField(
              label: "Peso (kg)",
              error: "Insira seu peso!",
              controller: _weightController),
          buildTextFormField(
              label: "Altura (cm)",
              error: "Insira uma altura!",
              controller: _heightController),
          RadioListTile(
            value: 1,
            groupValue: pessoa.genero,
            activeColor: Colors.red,
            title: Text("Mulher"),
            onChanged: (value) {
              setState(() {
                print("value: $value");
                pessoa.genero = value;
              });
            },
          ),
          RadioListTile(
            value: 2,
            groupValue: pessoa.genero,
            activeColor: Colors.green,
            title: Text("Homem"),
            onChanged: (value) {
              setState(() {
                print("value: $value");
                pessoa.genero = value;
              });
            },
          ),
          buildTextResult(),
          buildCalculateButton(),
        ],
      ),
    );
  }

  void calculateImc() {
    // double weight = double.parse(_weightController.text);
    pessoa.setPeso = double.parse(_weightController.text);
    // double height = double.parse(_heightController.text) / 100.0;
    pessoa.setAltura = double.parse(_heightController.text) / 100.0;
    // double imc = weight / (height * height);
    double imc = pessoa.getPeso / (pessoa.getAltura * pessoa.getAltura);

    setState(() {
      _result = "IMC = ${imc.toStringAsPrecision(2)}\n";
      if (imc < 18.6) {
        _result += "Abaixo do peso";
        cor = Colors.redAccent;
      } else if (imc < 25.0) {
        _result += "Peso ideal";
        cor = Colors.green;
      } else if (imc < 30.0) {
        _result += "Levemente acima do peso";
        cor = Colors.greenAccent;
      } else if (imc < 35.0) {
        _result += "Obesidade Grau I";
        cor = Colors.orange;
      } else if (imc < 40.0) {
        _result += "Obesidade Grau II";
        cor = Colors.deepOrange;
      } else {
        _result += "Obesidade Grau IIII";
        cor = Colors.red;
      }
    });
  }

  Widget buildCalculateButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: RaisedButton(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            calculateImc();
          }
        },
        child: Text('CALCULAR', style: TextStyle(color: Colors.blueAccent)),
      ),
    );
  }

  Widget buildTextResult() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: Text(
        _result,
        textAlign: TextAlign.center,
        style:
            TextStyle(color: cor, fontWeight: FontWeight.bold, fontSize: 18.0),
      ),
    );
  }

  Widget buildTextFormField(
      {TextEditingController controller, String error, String label}) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: (text) {
        return text.isEmpty ? error : null;
      },
    );
  }
}
