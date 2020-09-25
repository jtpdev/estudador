import 'package:estudador/models/planoestudo.dart';
import 'package:estudador/services/planoestudo.dart';
import 'package:estudador/widgets/planoestudo.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PlanoEstudoService _planoEstudoService = PlanoEstudoService();
  List<PlanoEstudoModel> _planos = [];

  @override
  void initState() {
    super.initState();
    _updateList();
  }

  void _updateList() {
    _planoEstudoService.list().then((planos) {
      setState(() {
        this._planos = planos;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: _buildPlanosEstudos(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PlanoEstudoPage(),
            ),
          );
          _updateList();
        },
        tooltip: 'Adicionar',
        child: Icon(Icons.add),
      ),
    );
  }

  List<Widget> _buildPlanosEstudos() {
    return _planos.map(
      (p) {
        return GestureDetector(
          onTap: () {
            // TODO abrir tela para cronometrar estudo
          },
          child: Card(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      p.titulo,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${_printDuration(p.tempoestudado)} estudado',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      p.nivelatual.descricao,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).toList();
  }

  String _printDuration(seconds) {
    if (seconds == null) seconds = 0;
    var duration = Duration(milliseconds: seconds * 1000);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
