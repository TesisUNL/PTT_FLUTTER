import 'dart:async';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:ptt_rtmb/core/utils/widgets/multi_select.dart';
import '../../core/models/attraction/attraction.dart';
import '../../core/models/canton/canton.dart';
import '../../core/services/attraction/attraction_service.dart';
import '../../core/services/canton/canton_service.dart';
import 'attraction_selection.dart';

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

  late Future<List<Attraction>> attractions;
  Future<List<Attraction>> fetchAttractions(String cantonName) async =>
      await getAttractionsByCantonName(cantonName);

  bool _visible = false;

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
              for (var i = 0; i < snapshot.data!.length; i++)
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
                  onConfirm: (results) {
                    print(results);
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

  formListCantonSelectionButtonsDesign(String cantonName) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: buildAttractionsList(cantonName),
      ),
    );
  }

  // formListViewDesign(List<Canton>? cantons) {
  //   for (var i = 0; i < cantons!.length; i++) {
  //     print(cantons[i].name);
  //     print(cantons[i].description);
  //   }
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 7),
  //     child: ListView(
  //       shrinkWrap: true,
  //       scrollDirection: Axis.vertical,
  //       children: <Widget>[
  //         for (var i = 0; i < cantons.length; i++)
  //           Card(
  //             child: Row(
  //               children: <Widget>[
  //                 Expanded(
  //                     flex: 0,
  //                     child: Container(
  //                       width: 70,
  //                       height: 50,
  //                       decoration: BoxDecoration(
  //                           color: Colors.black,
  //                           image: DecorationImage(
  //                               image: NetworkImage(cantons[i].description),
  //                               fit: BoxFit.cover),
  //                           border: Border.all(width: 1)),
  //                     )),
  //                 Expanded(
  //                     child: SizedBox(
  //                   child: TextButton(
  //                     style: TextButton.styleFrom(
  //                         alignment: Alignment.centerLeft,
  //                         padding: EdgeInsets.only(left: 10, right: 60)),
  //                     onPressed: () {
  //                       _navigateAndDisplaySelection(context, cantons[i].name);
  //                     },
  //                     child: Text(
  //                       cantons[i].name,
  //                       textAlign: TextAlign.left,
  //                       style: TextStyle(
  //                           fontSize: 16,
  //                           color: Color.fromARGB(255, 140, 145, 150)),
  //                     ),
  //                   ),
  //                 )),
  //                 Expanded(
  //                     child: Visibility(
  //                   child: Container(
  //                     padding: EdgeInsets.all(0),
  //                     child: ListTile(
  //                       title: Align(
  //                           child: Text(
  //                             '5 Seleccionados',
  //                             style: TextStyle(
  //                                 fontSize: 10,
  //                                 color: Color.fromARGB(255, 140, 145, 150)),
  //                           ),
  //                           alignment: Alignment(11, 0)),
  //                       trailing: Icon(Icons.check_box, color: Colors.green),
  //                     ),
  //                   ),
  //                   maintainSize: true,
  //                   maintainAnimation: true,
  //                   maintainState: true,
  //                   visible: _visible ? true : false,
  //                 ))
  //               ],
  //             ),
  //           )
  //       ],
  //     ),
  //   );
  // }

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
        /*formItemsDesign(
            Icons.add_road_outlined,
            TextFormField(
              enabled: false,
              controller: pathLengthCtrl,
              decoration: new InputDecoration(
                labelText: 'Longitud de Ruta',
              ),
              keyboardType: TextInputType.number,
              maxLength: 10,
            )),*/
        formLabelDesign('Selecciona los puntos de interés: '),
        for (var i = 0; i < cantons!.length; i++)
          formListCantonSelectionButtonsDesign(cantons[i].name),
        //formListViewDesign(cantons),
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

  // // Un método que inicia SelectionScreen y espera por el resultado de
  // // Navigator.pop
  // _navigateAndDisplaySelection(BuildContext context, String name) async {
  //   // Navigator.push devuelve un Future que se completará después de que llamemos
  //   // Navigator.pop en la pantalla de selección!
  //   final result = await Navigator.push(
  //     context,
  //     // Crearemos la SelectionScreen en el siguiente paso!
  //     MaterialPageRoute(builder: (context) => AttractionSelection('')),
  //   );

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text("${result}"),
  //       duration: Duration(milliseconds: 300),
  //     ),
  //   );
  // }
}
