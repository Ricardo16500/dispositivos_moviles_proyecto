import '../Model/post.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Historial extends StatefulWidget {
  String name;

  Historial(this.name, this.app);

  final FirebaseApp app;
  @override
  _HistorialState createState() => _HistorialState(name);
}

class _HistorialState extends State<Historial> {
  String name;
  _HistorialState(this.name);

  final referenceDataBase = FirebaseDatabase.instance;
  List<DatosLlegada> vComp =[];


  @override
  void initState() {
    super.initState();


    referenceDataBase.reference().child("Compras")
        .orderByChild("user").equalTo(name.toString()).once()
        .then((DataSnapshot snapShot) {

      Map<dynamic,dynamic> DATA = snapShot.value;
      print(DATA);
      vComp.clear();
      setState(() {
        DATA.forEach((key,value){
          DatosLlegada dl = new DatosLlegada(value['nombre'].toString(), value['cantidad'].toString(), value['subtotal'].toString());
          vComp.add(dl);
        });
      });
      // ignore: unnecessary_statements


      setState(() {
        print('Length: ${vComp.length} ');
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.red[500],
        appBar: AppBar(backgroundColor: Colors.red[900], title: Text('Historial de pedidos \n usuario ${name}'),),
        body: Container(
            child: vComp.length == 0? Text('El usuario no realizó ninguna compra'):
            ListView.builder(
                itemCount: vComp.length,
                itemBuilder:  (context, index){

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(

                      elevation: 10.0,
                      margin: EdgeInsets.all(14.0),
                      child: ListTile(

                        title: Text('nombre ${vComp[index].nombre}',style: Theme.of(context).textTheme.subtitle,
                          textAlign: TextAlign.center,),
                        subtitle: Text('Cantidad:  ${vComp[index].cantidad} Bs \n SubTotal: ${vComp[index].subtotal}',style: Theme.of(context).textTheme.subtitle,
                          textAlign: TextAlign.center,),

                        onTap: (){
                          setState(() {







                          });

                        },
                      ),
                    ),
                  );
                }

            )
        ),

    );
  }
}
