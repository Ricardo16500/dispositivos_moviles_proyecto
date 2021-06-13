import '../Model/post.dart';
import 'package:flutter/material.dart';


class DesplegarPantalla extends StatefulWidget {
  String nam,pass;

  DesplegarPantalla(this.nam, this.pass);

  @override
  _DesplegarPantallaState createState() => _DesplegarPantallaState(nam,pass);
}

class _DesplegarPantallaState extends State<DesplegarPantalla> {
  String nam,pass;

  _DesplegarPantallaState(this.nam, this.pass);

  @override
  Widget build(BuildContext context) {
    LlevarDatos ld = new LlevarDatos();

    //ld =new LlevarDatos(ld.getName,ld.getPassword);
    Post p = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('Elegiste ${p.nombre}'),),
      body: Center(
        child: Text('name: ${nam } pass: ${pass} precio: ${p.precio}'),
      ),
    );
  }
}
