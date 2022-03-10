import 'package:flutter/material.dart';
import 'package:search_cep/models/result_cep.dart';
import 'package:search_cep/services/via_cep_service.dart';




class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _searchCepController = TextEditingController();
  bool _loading = false;
  bool _enableField = true;
  String? _result;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _searchCepController.clear();
  }

  void _resetFields() {
    _searchCepController.text = "";
    setState(() {
      _formKey = GlobalKey<FormState>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BUSCAR CEP'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: [
          //Icone refresh
          // ignore: prefer_const_constructors
          IconButton(icon: Icon(Icons.refresh),
              onPressed: _resetFields)
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildSearchCepTextField(),
              _buildSearchCepButton(),
              _buildResultForm(),
            ],
          ),
        ),
      )
    );
  }
  Widget _buildSearchCepTextField() {
    return TextField(
      autofocus: true,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: 'Digite um cep',
        labelStyle: TextStyle(
          fontSize: 20, color: Colors.orangeAccent
        ),
        helperText: '60000-000',
        helperStyle: TextStyle(
          fontSize: 12, color: Colors.black87
        )
      ),
      style: TextStyle(
          fontSize: 16, color: Colors.blue
      ),
      controller: _searchCepController,
      enabled: _enableField,
    );
  }
  Widget _buildSearchCepButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),

      child: ElevatedButton(
        onPressed: _searchCep,
        child: _loading ? _circularLoading() : Text('CONSULTAR'),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
          backgroundColor: MaterialStateProperty.all(Colors.orange),
          shadowColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.onSurface),
        ),
      ),
      );
  }

  void _searching(bool enable) {
    setState(() {
        _result = enable ? '' : _result;
        _loading = enable;
        _enableField = !enable;
    });
  }

  Widget _circularLoading() {
    return Container(
      height: 15.0,
      width: 15.0,
      child: CircularProgressIndicator(),
    );
  }

  Future _searchCep() async {
    _searching(true);
    final cep = _searchCepController.text;

    final resultCep = await ViaCepService.fetchCep(cep: cep);
    print(resultCep.localidade); // Exibindo somente a localidade no terminal

    setState(() {
      _result = resultCep.toJson();
    });
    _searching(false);
  }

  Widget _buildResultForm() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Text(_result ?? ''),
    );
  }
}



