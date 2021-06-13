import 'package:cloud_firestore/cloud_firestore.dart';
import 'transiciones.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';

class NewUser extends StatefulWidget {
  NewUser({this.app});
  final FirebaseApp app;


  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  final referenceDataBase = FirebaseDatabase.instance;
  TextEditingController tec1=TextEditingController();
  TextEditingController tec2=TextEditingController();
  TextEditingController tec3 = TextEditingController();
  TextEditingController tec4 = TextEditingController();

  bool flag = false;
  @override
  Widget build(BuildContext context) {
    final ref = referenceDataBase.reference();
    final userName = 'Name';
    final passName = 'Password';
    final emailName = 'email';
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red[400],
        body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("NUEVO USUARIO", style: TextStyle(fontSize: 20, color: Colors.black87),),
                  Expanded(
                    child: Container(
                      width:400,
                      height: 500,
                      color: Colors.red[400],
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Image(
                                image: NetworkImage('https://www.thedorset.co.uk/wp-content/uploads/2020/07/eoho.png'),
                                height: 50,

                              ),
                            ),

                            TextField(controller: tec1,decoration: InputDecoration(hintText: "Ingrese el nuevo usuario ",),keyboardType:  TextInputType.text,),
                            TextField(controller: tec2,decoration: InputDecoration(hintText: "Ingrese la contraseña "),style: TextStyle(fontSize: 15,color: Colors.green[900]),obscureText: true,),
                            TextField(controller: tec3,decoration: InputDecoration(hintText: "Reingrese la contraseña "),style: TextStyle(fontSize: 15,color: Colors.green[900]),obscureText: true,),
                            TextField(controller: tec4,decoration: InputDecoration(hintText: "Ingrese su email"),keyboardType: TextInputType.emailAddress,style: TextStyle(fontSize: 15,color: Colors.black87),),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      FlatButton(
                                        color: Colors.white,
                                        onPressed: (){
                                          if(tec2.text != tec3.text){
                                            flag = true;
                                          }
                                          else{

                                            ref
                                            .child('Users')
                                                .push()

                                                .set({
                                                  'user': tec1.text,
                                                  'password': tec2.text,
                                                  'email': tec4.text,
                                                })
                                                .asStream();




                                            Navigator.push(context, SizeRoute(page: HomePage()));
                                          }
                                        setState(() {
                                          if(flag){
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) => AlertDialog(
                                                title: Text("Reingresar contraseñas"),
                                                content: Text("¡Las contraseñas son diferentes!"),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context, 'ACEPTAR'),
                                                    child: const Text('ACEPTAR'),
                                                  ),
                                                ],
                                              ),
                                            );

                                          }
                                          tec1.text = "";
                                          tec2.text = "";
                                          tec3.text = "";
                                          tec4.text = "";
                                          flag = false;

                                        });

                                      },
                                          child: Text("ACEPTAR",style: TextStyle(fontSize: 20,color: Colors.red[900]),),),
                                      FlatButton(
                                        color: Colors.white,
                                        onPressed: (){
                                        Navigator.push(context, SizeRoute(page: HomePage()));
                                      },
                                        child:Text("CANCELAR",style: TextStyle(fontSize: 20,color: Colors.red[900]),), ),
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
                ],
              ),
            ),
          ),

    );
  }
}
