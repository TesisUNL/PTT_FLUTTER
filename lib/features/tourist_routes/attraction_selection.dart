// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';

// class AttractionSelection extends StatelessWidget {
//   String cantonAttractions = "";

//   AttractionSelection(String name) {
//     cantonAttractions = name;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Attraction Selection'),
//         automaticallyImplyLeading: false,
//       ),
//       body: Text(cantonAttractions),
//       persistentFooterButtons: <Widget>[
//         ElevatedButton(
//           onPressed: () {},
//           style: ElevatedButton.styleFrom(
//             primary: Colors.green,
//             alignment: Alignment.center,
//           ),
//           child: Icon(
//             Icons.check,
//             color: Colors.white,
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             Navigator.pop(context, 'Cancelado');
//           },
//           style: ElevatedButton.styleFrom(
//             primary: Colors.red,
//           ),
//           child: Icon(
//             Icons.clear,
//             color: Colors.white,
//           ),
//         ),
//       ],
//     );
//   }
// }

