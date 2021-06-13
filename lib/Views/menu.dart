

import 'historial.dart';
import 'paComprar.dart';
import '../Model/post.dart';
import 'transiciones.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'despdatos.dart';
import 'home.dart';

class Menu extends StatefulWidget {
  String na;
  String pa;

  Menu(this.na, this.pa, this.app);

  final FirebaseApp app;
  @override
  _MenuState createState() => _MenuState(na,pa);
}

class _MenuState extends State<Menu> {
  String na,pa;

  _MenuState(this.na, this.pa);

  var refe="";

  //LlevarDatos leer = new LlevarDatos();
  final referenceDataBase = FirebaseDatabase.instance;
  //final ref = referenceDataBase.reference();
   List<Post> pList=[];
   //List<DatosComprar> vCompras = [];
   List<DatosComprar> vCompras = [];
  @override
  void initState() {
    super.initState();

    referenceDataBase.reference().child("Comidas").orderByChild('nombre')
        .once()
        .then((DataSnapshot snapShot) {

      var DATA = snapShot.value;
      print(DATA);
      pList.clear();
      // ignore: unnecessary_statements
      DATA.forEach((value){
        Post post = new Post( value['nombre'].toString(),  value['precio'].toString());
        pList.add(post);
      });

      setState(() {
        print('Length: ${pList.length} ');
      });

    });
  }

  List imagenes = ["https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Bife_de_chorizo_%283%29.jpg/300px-Bife_de_chorizo_%283%29.jpg",
    "https://recetadepollo.org/wp-content/uploads/Receta-de-pollo-canasta.jpg",
    "https://cdn.colombia.com/gastronomia/2012/12/11/pique-macho-3502.jpg",
    "https://saboresbolivianos.com/wp-content/uploads/sajta-de-pollo.jpg",
    "https://www.cocina-boliviana.com/base/stock/Recipe/147-image/147-image_web.jpg",
    "https://www.turistum.com/wp-content/uploads/2015/01/chicharron-boliviano.png",
    "https://gastronomiabolivia.com/wp-content/uploads/2020/02/Pollo-al-horno.jpg",
    "https://unaricareceta.com/wp-content/uploads/2020/11/chairo-paceno.jpg"
  ];
  int _n = 1;
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(backgroundColor: Colors.red[500], title: Text("MENU",style: TextStyle(fontSize: 20,color: Colors.black),),
          actions:<Widget>[
            IconButton(icon: Icon(Icons.add_shopping_cart_rounded),
                onPressed: (){
              setState(() {
                if (vCompras.length >0) {
                  Navigator.push(
                      context, FadeRoute(page: Compras(vCompras, na, pa)));
                }
                else{
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text('Error al acceder '),
                      content: Text("¡No selecciono ningun elemento para comprar!"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'ACEPTAR'),
                          child: const Text('ACEPTAR'),
                        ),
                      ],
                    ),
                  );
                }
              });

            }),
          mymenu(),
        ],
        ),
        body: Container(


          child: pList.length == 0? Text("No se encontro Data"):
          ListView.builder(
                  itemCount: pList.length,
                  itemBuilder:  (context, index){

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(

                          elevation: 10.0,
                          margin: EdgeInsets.all(14.0),
                        child: ListTile(
                              leading: CircleAvatar(
                              //child: Expanded(
                                child: Image(
                                  image: NetworkImage(imagenes[index]),
                                  height: 20,

                              ),
                              ),
                              title: Text('nombre ${pList[index].nombre}',style: Theme.of(context).textTheme.subtitle,
                              textAlign: TextAlign.center,),
                              subtitle: Text('Precio:  ${pList[index].precio} Bs',style: Theme.of(context).textTheme.subtitle,
                              textAlign: TextAlign.center,),

                              onTap: (){
                              setState(() {

                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) => sid(pList[index].nombre,pList[index].precio,index),
                                );



                      /*Post compras = new Post(pList[index].nombre.toString(),pList[index].precio.toString());
                            pCompras.add(compras);
                            print(pCompras[0].nombre);*/
                          });
                              ;
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Item elegido ${pList[index].nombre}')));
                      },
                      ),
                      ),
                    );
                  }

              )

        ),
      ),
    );
  }
  Widget sid(nom,precio,index){
    _n = 1;
    return StatefulBuilder(
        builder: (context, setState) {
        return new SimpleDialog(//agregar build

          title: Text('Producto seleccionado: ${nom}'),
          children: <Widget>[
            Center(child: Text('Precio: ${precio}')),
            Center(child: Text('Cantidad del producto: ')),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      child: IconButton(icon: Icon(Icons.minimize),
                        onPressed: (){
                          setState(() {
                            print('se presiono este boton');
                            if(_n!=1){
                              _n--;
                              print(_n.toString());
                            }
                          });
                        },),
                    ),

                    Text(_n.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    FloatingActionButton(
                      child: IconButton(icon: Icon(Icons.add),
                        onPressed: (){
                          setState(() {
                            print('se presiono este boton');
                            _n++;
                            print(_n.toString());
                          });
                        },),
                    ),
                  ],
                ),
              ),
            ),

            FlatButton(
                color: Colors.white,
                child: Text('ACEPTAR',style: TextStyle(fontSize: 20,color: Colors.red[900]),),
            onPressed: (){
                setState(() {
                  var st = _n* double.parse(precio);
                  DatosComprar comp = new DatosComprar(nom, precio, _n.toString(),st.toString());
                  vCompras.add(comp);
                });
                Navigator.pop(context, 'ACEPTAR');
          }

            )
          ],
        );
      }
    );
  }
  Widget mymenu(){
    return PopupMenuButton(
      itemBuilder: (ctx)=>[
        PopupMenuItem (child: Text("Historial pedidos "),value: '0',),

        PopupMenuItem (child: Text("Salir "),value: '1',),
      ],

      onSelected: (value){
        setState(() {
            switch(value){
              case '0':
                Navigator.push(
                    context, RotationRoute(page: Historial(na,null)));
                break;
              case '1':
                final FirebaseAuth _auth = FirebaseAuth.instance;

                Future<void> _signOut() async {
                  await _auth.signOut();
                }
                Navigator.push(
                    context, RotationRoute(page: HomePage()));
                break;

            }
        });
      },
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
