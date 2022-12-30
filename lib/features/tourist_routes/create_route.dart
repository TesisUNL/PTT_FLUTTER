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

  @override
  void initState() {
    super.initState();
    cantons = fetchCantons();
  }

  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> formValues = {};

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
                    child: formUI(snapshot.data, formValues),
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

  buildAttractionsList(String cantonName, Map<dynamic, dynamic> formValues) {
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
                title: const Text("Attractions"),
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
                onConfirm: (List<Attraction> result) {
                  formValues[cantonName] = result.map((e) => e.id).toList();
                },
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

  formListCantonSelectionButtonsDesign(
      String cantonName, Map<dynamic, dynamic> formValues) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(0),
        child: buildAttractionsList(cantonName, formValues),
      ),
    );
  }

  Widget formUI(List<Canton>? cantons, Map<dynamic, dynamic> formValues) {
    return Column(
      children: <Widget>[
        formItemsDesign(
            Icons.route_outlined,
            TextFormField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Nombre de Ruta',
              ),
              validator: validateName,
            )),
        formLabelDesign('Selecciona los puntos de interés: '),
        for (var i = 0; i < cantons!.length; i++)
          formListCantonSelectionButtonsDesign(cantons[i].name, formValues),
        GestureDetector(
            onTap: () {
              save(formValues);
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

  save(Map<dynamic, dynamic> formValues) async {
    final List selectedAttractions =
        formValues.values.expand((i) => i).toList();

    final List<String> selectedAttractionsIds =
        selectedAttractions.map((e) => e.toString()).toList();

    if (keyForm.currentState!.validate() && selectedAttractions.length >= 2) {
      final response =
          await postTouristRoute(nameCtrl.text, selectedAttractionsIds, 0);
      print(response);
      print("Ruta ${nameCtrl.text} creada exitosamente");
      keyForm.currentState!.reset();
    } else {
      print("Ruta ${nameCtrl.text} no creada, ocurrió un error");
    }
  }
}
