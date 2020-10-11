import 'package:flutter/material.dart';
import 'package:pokedio/app/modules/domain/pokemon.dart';
import 'package:pokedio/app/modules/home/home_controller.dart';
import 'package:pokedio/app/modules/home/home_module.dart';

class PaginaDetalhe extends StatefulWidget {
  final Pokemon poke;

  PaginaDetalhe({this.poke});

  @override
  _PaginaDetalheState createState() => _PaginaDetalheState();
}

class _PaginaDetalheState extends State<PaginaDetalhe> {
  bool mostraExpandido = true;

  final HomeController controller = HomeModule.to.get<HomeController>();

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(widget.poke.name),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.favorite), onPressed: null),
          IconButton(
              icon: Icon(Icons.person_add), onPressed: () => adicionaLista()),
        ],
      ),
      body: GestureDetector(
        onTap: () => {
          setState(() {
            mostraExpandido = !mostraExpandido;
          })
        },
        child: Center(
          child: Hero(
            tag: widget.poke.uniqueId,
            child: Image.network(
              mostraExpandido
                  ? widget.poke.imageUrlHiRes
                  : widget.poke.imageUrl,
            ),
          ),
        ),
      ),
    );
  }

  adicionaLista() {
    controller.adicionaLista(widget.poke);
    _key.currentState.showSnackBar(
      SnackBar(content: Text("Guardado!")),
    );
  }
}
