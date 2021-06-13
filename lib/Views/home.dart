import 'new_user.dart';
import '../Model/post.dart';

import 'transiciones.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'menu.dart';

class HomePage extends StatefulWidget {
  HomePage({this.app});
  final FirebaseApp app;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final referenceDataBase = FirebaseDatabase.instance;
  var flag = false;

  //final AuthService _authService = AuthService();
  List datos = [];
  List datos2 = [];
  List usuarios = [];
  int res1 = 0;
  int res2= 0;
  void getUsers() async{
    CollectionReference collectionreference =
    FirebaseFirestore.instance.collection("users");
    QuerySnapshot user = await collectionreference.get();
    //QuerySnapshot user = await collectionreference.get();
    if (user.docs.length != 0){
      for (var doc in user.docs){
        print(doc.data());
        usuarios.add(doc.data());
      }
    }
  }

  TextEditingController tec1=TextEditingController();
  TextEditingController tec2=TextEditingController();
  List<LlevarDatos> uList = [];
  //LlevarDatos dat = new LlevarDatos();

  void buscarData(){
    referenceDataBase.reference()
        .child("Users")
        .orderByChild('user')
        .equalTo(tec1.text)
        .orderByChild('password')
        .equalTo(tec2.text)
        .once()
        .then((DataSnapshot snapshot ) {

      //uList.clear();
      var data = snapshot.value;
      data.forEach((value){
        res1 ++;
        print(value['user'].toString());
        //dat.setName(value['user'].toString());
        //dat.setPassword(value['password'].toString());
        //LlevarDatos lv = new LlevarDatos(value['user'].toString(), value['password'].toString());
        //uList.add(lv);
      });
    });
  }
  Future <GetDatos> buscar() async {
    print("estamos aqui");
    referenceDataBase.reference()
        .child("Users")
        .orderByChild('user')
        .equalTo(tec1.text)
       /* .orderByChild('password')
        .equalTo(tec2.text)*/
        .once()
        .then((DataSnapshot snapshot ){
      Map<dynamic,dynamic> valores =  snapshot.value;
      // List mList = valores.values.toList();
      setState(() {

        valores.forEach ((key,values){
          print("llega");
          LlevarDatos gt = new LlevarDatos();
          //gt = LlevarDatos(values["user"].toString(),values["password"].toString() );
          gt.setName(values['user'].toString());
          gt.setPassword(values['password'].toString());

          print(values["user"].toString());
          print(values["password"].toString());
          /*dat.setName(values['user'].toString());
        dat.setPassword(values['password'].toString());*/
          print('datos llegado ${gt.getName()}');
          print('datos get pass ${gt.getPassword()}');

          if ( gt.getName() != null ){
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text('Bienvenido '),
                content: Text("¡Bienvenido al sistema !"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () =>Navigator.push(context, FadeRoute(page: Menu(gt.getName(),gt.getPassword(), null))),
                    child: const Text('ACEPTAR'),
                  ),
                ],
              ),
            );

          }
          else{
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text('Error al ingresar '),
                content: Text("¡Revise sus datos e intente nuevamente!"),
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
      });

    }) ;
  }




  @override
  Widget build(BuildContext context) {
    final ref = referenceDataBase.reference();
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,

        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    width:400,
                    height: 500,
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Image(
                              image: NetworkImage('https://www.thedorset.co.uk/wp-content/uploads/2020/07/eoho.png'),
                              height: 50,

                            ),
                          ),
                          Text("INICIAR SESIÓN",style: TextStyle(fontSize: 20,color: Colors.black)),
                          TextField(controller: tec1,decoration: InputDecoration(hintText: "Ingrese el usuario ",),keyboardType:  TextInputType.text,),
                          TextField(controller: tec2,decoration: InputDecoration(hintText: "Ingrese la contraseña "),style: TextStyle(fontSize: 15,color: Colors.green[900]),obscureText: true,),
                          FlatButton(
                            color: Colors.white,
                              child: Text("ACEPTAR",style: TextStyle(fontSize: 20,color: Colors.red[900])),
                              onPressed: () {
                              print(tec1.text);
                              print(tec2.text);





                              setState(() {
                                buscar();




                              });
                              }),
                          FlatButton(
                            child: Text("Crear nuevo usuario",style: TextStyle(fontSize: 15, color: Colors.blue[900]),),
                              onPressed: (){
                                Navigator.push(context, FadeRoute(page: NewUser()));
                              },
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }


}
