import 'package:flutter/material.dart';
class Post{
  String nombre;
  String precio;

  Post(this.nombre, this.precio);
}
class GetDatos{
  String _name;
  String _password;

  GetDatos(this._name, this._password);
}
class LlevarDatos{
  String _name="";
  String _password="";

 //LlevarDatos(this.name, this.password);



  String  getPassword(){
    return _password;
  }

  String getName(){
    return _name;
  }
  void setName(String value){
    _name = value;
  }
  void setPassword(String value){
    _password = value;
  }
}
class DatosComprar{
  String nombre;
  String precio;
  String cantidad;
  String subtotal;

  DatosComprar(this.nombre, this.precio, this.cantidad, this.subtotal);
}
class DatosLlegada{
  String nombre;
  String cantidad;
  String subtotal;

  DatosLlegada(this.nombre, this.cantidad, this.subtotal);
}
