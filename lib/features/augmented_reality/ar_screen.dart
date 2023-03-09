import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ARScreen extends StatefulWidget {
  @override
  _ARScreenState createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  late ArCoreController? _arCoreController;
  late ArCoreNode? _objectNode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        enableTapRecognizer: true,
        enableUpdateListener: true,
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    _arCoreController = controller;

    // Cargamos el objeto 3D desde un archivo glTF en la memoria del dispositivo
    ArCoreReferenceNode object = ArCoreReferenceNode(
      name: 'object',
      objectUrl: 'assets/models/bird_model.gltf',
    );

    // Posicionamos el objeto en el centro del mundo AR
    ArCoreNode objectNode = ArCoreNode(
      shape: object.shape,
      position: vector.Vector3.zero(),
    );

    // Agregamos el objeto a la vista AR
    _arCoreController!.addArCoreNode(objectNode);

    setState(() {
      _objectNode = objectNode;
    });
  }

  @override
  void dispose() {
    _arCoreController?.dispose();
    super.dispose();
  }
}
