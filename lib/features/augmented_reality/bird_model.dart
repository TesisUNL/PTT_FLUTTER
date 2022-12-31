// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
// import 'package:flutter/services.dart';
// import 'package:vector_math/vector_math_64.dart' as vector;

// class ARCore extends StatefulWidget {
//   ARCore({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   _ARCoreState createState() => _ARCoreState();
// }

// class _ARCoreState extends State<ARCore> {
//   late ArCoreController arCoreController;

//   _onArCoreViewCreated(ArCoreController _arcoreController) {
//     arCoreController = _arcoreController;
//     arCoreController.onNodeTap = (name) => onTapHandler(name);
//     _addSphere(arCoreController);
//     _addCube(arCoreController);
//     _addCylinder(arCoreController);
//     _addBird(arCoreController);
//   }

//   void onTapHandler(String name) {
//     showDialog<void>(
//       context: context,
//       builder: (BuildContext context) =>
//           AlertDialog(content: Text('onNodeTap on $name')),
//     );
//   }

//   void _addBird(ArCoreController _arcoreController) async {
//     final moonMaterial = ArCoreMaterial(color: Colors.grey);

//     final moonShape = ArCoreSphere(
//       materials: [moonMaterial],
//       radius: 0.03,
//     );

//     final moon = ArCoreNode(
//       shape: moonShape,
//       position: vector.Vector3(0.2, 0, 0),
//       rotation: vector.Vector4(0, 0, 0, 0),
//     );

//     final ByteData bytes = await rootBundle.load('assets/bird.png');
//     final Uint8List list = bytes.buffer.asUint8List();

//     final birdMaterial = ArCoreMaterial(
//         color: Color.fromARGB(120, 66, 134, 244), textureBytes: list);

//     final birdShape = ArCoreSphere(
//       materials: [birdMaterial],
//       radius: 0.1,
//     );

//     final bird = ArCoreNode(
//       shape: birdShape,
//       children: [moon],
//       position: vector.Vector3(0.0, 1.0, 0.0),
//     );

//     _arcoreController.addArCoreNodeWithAnchor(bird);
//   }

//   _addSphere(ArCoreController _arCoreController) {
//     final material = ArCoreMaterial(
//       color: Colors.deepPurple,
//     );
//     final sphere = ArCoreSphere(
//       materials: [material],
//       radius: 0.2,
//     );
//     final node = ArCoreNode(
//       shape: sphere,
//       position: vector.Vector3(0, -0.3, -1),
//     );
//     _arCoreController.addArCoreNode(node);
//   }

//   _addCylinder(ArCoreController _arCoreController) {
//     final material = ArCoreMaterial(color: Colors.green, reflectance: 1);
//     final cylinder = ArCoreCylinder(
//       materials: [material],
//       radius: 0.3,
//       height: 0.1,
//     );
//     final node = ArCoreNode(
//       shape: cylinder,
//       position: vector.Vector3(-0.3, -1, -1.0),
//     );
//     _arCoreController.addArCoreNode(node);
//   }

//   _addCube(ArCoreController _arCoreController) {
//     final material = ArCoreMaterial(color: Colors.pink, metallic: 1);
//     final cube =
//         ArCoreCube(materials: [material], size: vector.Vector3(0.5, 0.5, 0.5));
//     final node = ArCoreNode(
//       shape: cube,
//       position: vector.Vector3(0.5, -3, -3),
//     );
//     _arCoreController.addArCoreNode(node);
//   }

//   @override
//   void dispose() {
//     arCoreController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: ArCoreView(
//           onArCoreViewCreated: _onArCoreViewCreated, enableTapRecognizer: true),
//     );
//   }
// }
