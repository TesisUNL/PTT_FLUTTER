import 'package:flutter/material.dart';

import 'package:ptt_rtmb/features/layout/details.dart';

import '../../../enviroment.dart';
import '../../models/attraction/attraction.dart';

class HorizontalPlaceItem extends StatelessWidget {
  final Attraction place;

  HorizontalPlaceItem({required this.place});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: InkWell(
        child: Container(
          height: 250.0,
          width: 140.0,
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  image: NetworkImage("${place.image}"),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/default.jpeg',
                        height: 178.0, width: 140.0, fit: BoxFit.fitWidth);
                  },
                  placeholder: AssetImage("assets/jar-loading.gif"),
                  height: 178.0,
                  width: 140.0,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 7.0),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${place.name}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Details(place: place);
              },
            ),
          );
        },
      ),
    );
  }
}
