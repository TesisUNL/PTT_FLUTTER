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
  const CreateRoutePage({Key? key}) : super(key: key);

  @override
  _CreateRoutePageState createState() => _CreateRoutePageState();
}

class _CreateRoutePageState extends State<CreateRoutePage> {
  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController pathLengthCtrl = TextEditingController();

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
      appBar: AppBar(
        title: const Text('Creación de ruta'),
      ),
      body: FutureBuilder<List<Canton>>(
          future: cantons,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Form(
                    key: keyForm,
                    child: formUI(snapshot.data, formValues),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const CircularProgressIndicator();
          }),
    );
  }

  formItemsDesign(icon, item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
    );
  }

  formLabelDesign(label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Card(
          child: ListTile(
              title: Text(
        label,
        style: const TextStyle(
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
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                buttonIcon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.blue,
                ),
                buttonText: Text(
                  cantonName,
                  style: const TextStyle(
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
        return const CircularProgressIndicator();
      },
    );
  }

  formListCantonSelectionButtonsDesign(
      String cantonName, Map<dynamic, dynamic> formValues) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(0),
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
              margin: const EdgeInsets.all(20.0),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  color: const Color.fromARGB(255, 55, 115, 150)),
              padding: const EdgeInsets.all(10),
              child: const Text("Guardar",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
            ))
      ],
    );
  }

  String? validateName(String? value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "El nombre es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "El nombre debe de ser a-z y A-Z";
    }
    return null;
  }

  void _displayDialogAndroid(BuildContext context, String content, bool error) {
    showDialog(
      // barrierDismissible: true
      barrierDismissible:
          false, // this is to close the dialog when clicking outside
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        title: const Text('Info'),
        content: Column(
          mainAxisSize:
              MainAxisSize.min, // this determines the height of the dialog
          children: [
            Text(content),
            const SizedBox(height: 10),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              if (error) {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              } else {
                keyForm.currentState!.reset();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  save(Map<dynamic, dynamic> formValues) async {
    final List selectedAttractions =
        formValues.values.expand((i) => i).toList();

    final List<String> selectedAttractionsIds =
        selectedAttractions.map((e) => e.toString()).toList();

    if (keyForm.currentState!.validate() && selectedAttractions.length >= 2) {
      final response =
          await postTouristRoute(nameCtrl.text, selectedAttractionsIds, 0);
      if (response.name == nameCtrl.text) {
        _displayDialogAndroid(
            context,
            "Ruta ${nameCtrl.text} creada exitosamente, tus rutas aparecerán en tu perfil",
            false);
      }
    } else {
      _displayDialogAndroid(
          context, "Ruta ${nameCtrl.text} no creada, ocurrió un error", true);
    }
  }
}
