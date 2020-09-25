import 'package:estudador/models/nivel.dart';
import 'package:estudador/models/planoestudo.dart';
import 'package:estudador/services/planoestudo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlanoEstudoPage extends StatefulWidget {
  @override
  _PlanoEstudoPageState createState() => _PlanoEstudoPageState();
}

class _PlanoEstudoPageState extends State<PlanoEstudoPage> {
  PlanoEstudoModel _planoEstudo = PlanoEstudoModel();
  PlanoEstudoService _planoEstudoService = PlanoEstudoService();

  var descricaoCtrl = TextEditingController();
  var qtdHorasCtrl = TextEditingController();

  var currentIndex;

  _save() async {
    _planoEstudo.niveis.sort((n1,n2) => n1.qtdhoras - n2.qtdhoras);
    _planoEstudo.nivelatual = _planoEstudo.niveis.first;
    await _planoEstudoService.save(_planoEstudo);
    Navigator.pop(context);
  }

  _addAoPlano() {
    if (_validarNivel()) {
      return;
    }
    setState(() {
      _planoEstudo.niveis.add(
        NivelModel(
          descricao: descricaoCtrl.text,
          qtdhoras: int.parse(qtdHorasCtrl.text),
        ),
      );
      descricaoCtrl.clear();
      qtdHorasCtrl.clear();
    });
  }

  _alterarDoPlano() {
    if (_validarNivel()) {
      return;
    }
    setState(() {
      var nivel = _planoEstudo.niveis[currentIndex];
      nivel.descricao = descricaoCtrl.text;
      nivel.qtdhoras = int.parse(qtdHorasCtrl.text);

      descricaoCtrl.clear();
      qtdHorasCtrl.clear();
      currentIndex = null;
    });
  }

  _removeDoPlano(index) {
    setState(() {
      _planoEstudo.niveis.removeAt(index);
    });
  }

  _editarDoPlano(NivelModel n) {
    currentIndex = _planoEstudo.niveis.indexOf(n);
    setState(() {
      descricaoCtrl.text = n.descricao;
      qtdHorasCtrl.text = '${n.qtdhoras}';
    });
  }

  bool _validarNivel() {
    return descricaoCtrl.text == null ||
        descricaoCtrl.text.trim().isEmpty ||
        qtdHorasCtrl.text == null ||
        qtdHorasCtrl.text.trim().isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plano de estudo'),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 48, left: 32, right: 32),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: TextFormField(
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: "Título",
              ),
              style: TextStyle(fontSize: 20),
              onChanged: (value) {
                setState(() {
                  _planoEstudo.titulo = value;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8, top: 8),
            child: Text(
              "Níveis",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: TextFormField(
              controller: descricaoCtrl,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: "Descrição do nível",
              ),
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: qtdHorasCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Quantidade de horas",
                    ),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Visibility(
                  visible: currentIndex == null,
                  child: Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _addAoPlano,
                    ),
                  ),
                ),
                Visibility(
                  visible: currentIndex != null,
                  child: Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: _alterarDoPlano,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: Column(
              children: _planoEstudo.niveis.map(
                (n) {
                  return GestureDetector(
                    onTap: () => _editarDoPlano(n),
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                n.descricao,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                '${n.qtdhoras} horas',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => _removeDoPlano(
                                    _planoEstudo.niveis.indexOf(n)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: _planoEstudo.titulo != null &&
            _planoEstudo.titulo.trim().isNotEmpty &&
            _planoEstudo.niveis.isNotEmpty,
        child: FloatingActionButton(
          onPressed: () => _save(),
          child: Icon(Icons.check),
        ),
      ),
    );
  }
}
