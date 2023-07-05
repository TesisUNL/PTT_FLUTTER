import 'package:flutter/material.dart';
import 'package:ptt_rtmb/core/models/attraction/attraction.dart';

import '../../../features/layout/details_attraction.dart';

class VerticalPlaceItem extends StatelessWidget {
  final Attraction place;

  const VerticalPlaceItem({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        child: SizedBox(
          height: 70.0,
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: FadeInImage(
                  image: NetworkImage(place.image),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/default.jpeg',
                        height: 70.0, width: 70.0, fit: BoxFit.fitWidth);
                  },
                  placeholder: const AssetImage("assets/jar-loading.gif"),
                  height: 70.0,
                  width: 70.0,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15.0),
              SizedBox(
                height: 80.0,
                width: MediaQuery.of(context).size.width - 130.0,
                child: ListView(
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        place.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(height: 3.0),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.album_outlined,
                          size: 13.0,
                          color: Colors.blueGrey[300],
                        ),
                        const SizedBox(width: 3.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 200,
                          child: Text(
                            place.shortDescription,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Colors.blueGrey[300],
                            ),
                            textAlign: TextAlign.justify,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return DetailsAttraction(attraction: place);
              },
            ),
          );
        },
      ),
    );
  }
}
