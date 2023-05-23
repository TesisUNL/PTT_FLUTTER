import 'package:flutter/material.dart';
import 'package:ptt_rtmb/core/models/canton/canton.dart';
import 'package:ptt_rtmb/features/layout/details_canton.dart';

class HorizontalPlaceItem extends StatelessWidget {
  final Canton canton;
  const HorizontalPlaceItem({Key? key, required this.canton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: InkWell(
        child: SizedBox(
          height: 250.0,
          width: MediaQuery.of(context).size.width * 0.35,
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  image: NetworkImage(canton.flag_image),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/default.jpeg',
                        height: 170.0,
                        width: MediaQuery.of(context).size.width * 0.35,
                        fit: BoxFit.fitWidth);
                  },
                  placeholder: const AssetImage("assets/jar-loading.gif"),
                  height: 170.0,
                  width: MediaQuery.of(context).size.width * 0.35,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 2.0),
              Container(
                alignment: Alignment.center,
                child: Text(
                  canton.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return DetailsCanton(canton: canton);
              },
            ),
          );
        },
      ),
    );
  }
}
