import 'dart:async';

import 'package:estudador/models/planoestudo.dart';
import 'package:estudador/services/planoestudo.dart';
import 'package:estudador/utils/string.dart';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  PlanoEstudoModel planoEstudo;
  int index;

  TimerPage(index, planoEstudo)
      : this.planoEstudo = planoEstudo,
        this.index = index;

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  PlanoEstudoService planoEstudoService = PlanoEstudoService();

  Timer timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contador para ${widget.planoEstudo.titulo}'),
      ),
      body: Stack(
        children: [
          Center(
            child: GestureDetector(
              onTap: timer == null ? startCronometro : stopCronometro,
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: timer == null ? Colors.black : Colors.red,
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Align(
                  alignment: FractionalOffset.center,
                  child: Text(
                    StringUtils.printDuration(widget.planoEstudo.tempoestudado),
                    style: TextStyle(
                      fontSize: 24,
                      color: timer == null ? Colors.black : Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  startCronometro() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (widget.planoEstudo.tempoestudado == null) {
          widget.planoEstudo.tempoestudado = 0;
        }
        widget.planoEstudo.tempoestudado += 1;
        widget.planoEstudo.nivelatual = widget.planoEstudo.niveis.firstWhere(
            (p) => (p.qtdhoras * 3600) > widget.planoEstudo.tempoestudado,
            orElse: () => widget.planoEstudo.niveis.last);
        planoEstudoService.update(widget.index, widget.planoEstudo);
      });
    });
  }

  stopCronometro() {
    setState(() {
      timer.cancel();
      timer = null;
    });
  }
}
