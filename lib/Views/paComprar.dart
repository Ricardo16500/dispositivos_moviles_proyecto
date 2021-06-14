import '../Model/post.dart';
import 'transiciones.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'menu.dart';

class Compras extends StatefulWidget {
  List<DatosComprar> vCompras;
  String nom;
  String pass;
  final FirebaseApp app;


  Compras(this.vCompras, this.nom, this.pass,{this.app});

  @override
  _ComprasState createState() => _ComprasState(vCompras,nom,pass);
}

class _ComprasState extends State<Compras> {
  final referenceDataBase = FirebaseDatabase.instance;
  List<DatosComprar> vCompras;
  String nom;
  String pass;


  _ComprasState(this.vCompras, this.nom, this.pass);

  int _n = 1;

  String sumar(){
    double sum = 0;
    for (var i=0; i<vCompras.length;i++){
      sum += double.parse(vCompras[i].subtotal);
    }
    return sum.toString();

  }
  @override
  Widget build(BuildContext context) {
    final ref = referenceDataBase.reference();
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red[700],
        appBar: AppBar(
          backgroundColor: Colors.red[900],
          title: Text("Panel de revisión de compras "),
        ),
        body: Container(

          child: ListView.builder(
                      shrinkWrap: false,
                      itemCount: vCompras.length,
                      itemBuilder: (context,index){
                        return Padding(
                            padding:  const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 10.0,
                            margin: EdgeInsets.all(14.0),
                            child: ListTile(


                              title: Text('nombre ${vCompras[index].nombre}',style: Theme.of(context).textTheme.subtitle,
                                textAlign: TextAlign.center,),
                              subtitle: Text('Precio:  ${vCompras[index].precio} Bs \n Cantidad: ${vCompras[index].cantidad} \n SubTotal: ${vCompras[index].subtotal}',
                                style: Theme.of(context).textTheme.subtitle,
                                textAlign: TextAlign.center,),


                              onTap: (){
                                setState(() {

                                });


                              }
                            ),
                          ),
                        );
                      }),


            ),
          bottomNavigationBar: BottomAppBar(
              child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                 Text('Total: ${sumar()} Bs', style: TextStyle(fontSize: 16,color: Colors.red[900]),),

                    FlatButton(
                      color: Colors.white,
                        onPressed: (){
                        for (var i=0;i<vCompras.length;i++){
                          ref
                          .child('Compras')
                              .push()
                              .set({
                                'user': nom,
                                'password': pass,
                                'nombre': vCompras[i].nombre,
                                'cantidad': vCompras[i].cantidad,
                                'subtotal': vCompras[i].subtotal

                          })
                              .asStream();
                        }
                        setState(() {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('VENTA REALIZADA '),
                              content: Text("¡SE HA REALIZADO LA VENTA!"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>Navigator.push(context, ScaleRoute(page: Menu(nom,pass, null))),
                                  child: const Text('ACEPTAR'),
                                ),
                              ],
                            ),
                          );
                        });
                        },
                        child: Text("ACEPTAR",style: TextStyle(fontSize: 16,color: Colors.red[900]),),
                    ),
                  FlatButton(
                      onPressed: (){
                          setState(() {
                            vCompras.clear();
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                              title: Text('VENTA CANCELADA '),
                              content: Text("¡SE HA CANCELADO LA VENTA!"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>Navigator.push(context, ScaleRoute(page: Menu(nom,pass, null))),
                                  child: const Text('ACEPTAR'),
                                ),
                              ],
                            ),
                            );
                          });
                      },
                      child: Text("CANCELAR", style: TextStyle(fontSize: 20,color: Colors.red[900]))),
                ],
              ),
          ),


      ),
    );
  }
  void minus() {
    setState(() {
      if (_n != 1)
        _n--;
    });
  }
  void add() {
    setState(() {
      _n++;
    });
  }
}
