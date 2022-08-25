import 'package:babylonjs_viewer/babylonjs_viewer.dart';
import 'dart:async';
import 'package:flutter/material.dart';


// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class ModelPage extends StatefulWidget {
  @override
  _Model3DPageState createState() => _Model3DPageState();
}

class _Model3DPageState extends State<ModelPage> {

  @override
  Widget build(BuildContext context) {

     return Scaffold(
      appBar: AppBar(title: Text("Guía Virtual")),
      body: BabylonJSViewer(src: "assets/bird.glb"));
  }
}
