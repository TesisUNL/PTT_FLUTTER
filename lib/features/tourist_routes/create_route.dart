import 'dart:async';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../core/models/attraction/attraction.dart';
import '../../core/models/canton/canton.dart';
import '../../core/services/attraction/attraction_service.dart';
import '../../core/services/canton/canton_service.dart';
import 'package:ptt_rtmb/core/services/rotues/routes_service.dart';

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

  //Attraction Service
  Future<List<Attraction>> fetchAttractions(String cantonName) async =>
      await getAttractionsByCantonName(cantonName);

  late Set selectedAttractions = Set();
  late Set actualAttractions = Set();

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

  buildAttractionsList(String cantonName) {
    return FutureBuilder<List<Attraction>>(
      future: fetchAttractions(cantonName),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: <Widget>[
              MultiSelectDialogField(
                items: snapshot.data!
                    .map((attraction) =>
                        MultiSelectItem(attraction, attraction.name))
                    .toList(),
                title: Text("Attracciones"),
                selectedColor: Colors.blue,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                buttonIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.blue,
                ),
                buttonText: Text(
                  cantonName,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
                onConfirm: (List<Attraction> results) {
                  print('selected ${selectedAttractions}');
                  print('actual ${actualAttractions}');

                  for (var i = 0; i < selectedAttractions.length; i++) {
                    print('results ${results[i].id}');
                    if (!results.contains(selectedAttractions.elementAt(i))) {
                      selectedAttractions
                          .remove(selectedAttractions.elementAt(i));
                    }
                  }
                  var timer = Timer(
                      Duration(seconds: 2), () => actualAttractions.clear());
                },
                onSelectionChanged:
                    ((List<Attraction> actualSelectedAttractions) {
                  for (var i = 0; i < actualSelectedAttractions.length; i++) {
                    selectedAttractions.add(actualSelectedAttractions[i].id);
                    actualAttractions.add(actualSelectedAttractions[i].id);
                  }
                }),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  formListCantonSelectionButtonsDesign(String cantonName) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(0),
        child: buildAttractionsList(cantonName),
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
        formLabelDesign('Selecciona los puntos de interés: '),
        for (var i = 0; i < cantons!.length; i++)
          formListCantonSelectionButtonsDesign(cantons[i].name),
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

  save() async {
    print("Faltan Campos por llenar");
    print(selectedAttractions);
    if (keyForm.currentState!.validate() && selectedAttractions.length > 2) {
      await postTouristRoute(nameCtrl.text, selectedAttractions, 0);
      print("Ruta ${nameCtrl.text} creada exitosamente");
      keyForm.currentState!.reset();
    }
  }
}
