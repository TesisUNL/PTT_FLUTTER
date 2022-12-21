import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ptt_rtmb/core/utils/widgets/multi_select.dart';

class AttractionSelection extends StatelessWidget {
  late String future = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attraction Selection'),
        automaticallyImplyLeading: false,
      ),
      body: MultiSelectList(),
      persistentFooterButtons: <Widget>[
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
            alignment: Alignment.center,
          ),
          child: Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, 'Cancelado');
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          child: Icon(
            Icons.clear,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
