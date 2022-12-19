import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ptt_rtmb/core/utils/widgets/multi_select.dart';

import '../../core/models/canton/canton.dart';
import '../../core/services/canton/canton_service.dart';

class CreateRoutePage extends StatefulWidget {
  @override
  _CreateRoutePageState createState() => _CreateRoutePageState();
}

class _CreateRoutePageState extends State<CreateRoutePage> {
  GlobalKey<FormState> keyForm = new GlobalKey();
  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController pathLengthCtrl = new TextEditingController();

  //Canton Service
  late Future<List<Canton>> cantons;
  Future<List<Canton>> fetchCantons() async => await getCantons();

  @override
  void initState() {
    super.initState();
    cantons = fetchCantons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Creación de ruta'),
      ),
      body: FutureBuilder<List<Canton>>(
          future: cantons,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new SingleChildScrollView(
                child: new Container(
                  margin: new EdgeInsets.all(10.0),
                  child: new Form(
                    key: keyForm,
                    child: formUI(snapshot.data),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          }),
    );
  }

  formItemsDesign(icon, item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
    );
  }

  formLabelDesign(label) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Card(
          child: ListTile(
              title: Text(
        label,
        style: TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
            color: Color.fromARGB(255, 140, 145, 150)),
      ))),
    );
  }

  formListViewDesign(List<Canton>? cantons) {
    for (var i = 0; i < cantons!.length; i++) {
      print(cantons[i].name);
      print(cantons[i].description);
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          for (var i = 0; i < cantons.length; i++)
            Card(
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 0,
                      child: SizedBox(
                        width: 70,
                        height: 50,
                        child: Image(
                            image: NetworkImage(cantons[i].description),
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.fill),
                      )),
                  Expanded(
                      child: SizedBox(
                    child: TextButton(
                      style: TextButton.styleFrom(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10, right: 60)),
                      onPressed: () {},
                      child: Text(
                        cantons[i].name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 140, 145, 150)),
                      ),
                    ),
                  )),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.all(0),
                    child: ListTile(
                      leading: Icon(Icons.check_box, color: Colors.green),
                      title: Align(
                          child: Text(
                            '5 Seleccionados',
                            style: TextStyle(
                                fontSize: 10,
                                color: Color.fromARGB(255, 140, 145, 150)),
                          ),
                          alignment: Alignment(-90, 0)),
                    ),
                  ))
                ],
              ),
            )
        ],
      ),
    );
  }

  Widget formUI(List<Canton>? cantons) {
    return Column(
      children: <Widget>[
        formItemsDesign(
            Icons.route_outlined,
            TextFormField(
              controller: nameCtrl,
              decoration: new InputDecoration(
                labelText: 'Nombre de Ruta',
              ),
              validator: validateName,
            )),
        formItemsDesign(
            Icons.add_road_outlined,
            TextFormField(
              enabled: false,
              controller: pathLengthCtrl,
              decoration: new InputDecoration(
                labelText: 'Longitud de Ruta',
              ),
              keyboardType: TextInputType.number,
              maxLength: 10,
            )),
        formLabelDesign('Selecciona los puntos de interés: '),
        formListViewDesign(cantons),
        //MultiSelectList(),
        GestureDetector(
            onTap: () {
              save();
            },
            child: Container(
              margin: new EdgeInsets.all(20.0),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  color: Color.fromARGB(255, 55, 115, 150)),
              child: Text("Guardar",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              padding: EdgeInsets.all(10),
            ))
      ],
    );
  }

  String? validateName(String? value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value?.length == 0) {
      return "El nombre es necesario";
    } else if (!regExp.hasMatch(value!)) {
      return "El nombre debe de ser a-z y A-Z";
    }
    return null;
  }

  save() {
    print(keyForm.currentState);
    if (keyForm.currentState!.validate()) {
      print("Nombre ${nameCtrl.text}");
      print("Tamaño de Ruta ${pathLengthCtrl.text}");
      keyForm.currentState!.reset();
    }
  }
}
