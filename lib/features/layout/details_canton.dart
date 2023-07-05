import 'package:flutter/material.dart';
import 'package:ptt_rtmb/core/utils/widgets/AppLoading.dart';
import 'package:ptt_rtmb/features/video_player/video_player.dart';
import '../../core/models/canton/canton.dart';
import '../../core/models/attraction/attraction.dart';
import '../../core/services/attraction/attraction_service.dart';
import '../../core/utils/widgets/vertical_place_item.dart';

class DetailsCanton extends StatelessWidget {
  final Canton canton;

  const DetailsCanton({Key? key, required this.canton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 10.0),
          buildVideoPlayer(context),
          const SizedBox(height: 20),
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      canton.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  canton.description,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 12.0,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 15.0),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Atracciones en el Canton:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              ),
              buildVerticalList(),
            ],
          ),
        ],
      ),
    );
  }

  buildVideoPlayer(BuildContext context) {
    if (canton.presentation_video.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: FadeInImage(
            image: NetworkImage(canton.flag_image),
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/default.jpeg',
                height: 250.0,
                width: MediaQuery.of(context).size.width - 40.0,
                fit: BoxFit.cover,
              );
            },
            placeholder: const AssetImage("assets/jar-loading.gif"),
            height: 250.0,
            width: MediaQuery.of(context).size.width - 40.0,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return VideoPlayerWidget(canton: canton);
    }
  }

  buildVerticalList() {
    Future<List<Attraction>> fetchAttractions(String cantonName) async =>
        await getAttractionsByCantonName(cantonName);

    Future<List<Attraction>> attractions = fetchAttractions(canton.name);

    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  Attraction place = snapshot.data![index];
                  return VerticalPlaceItem(place: place);
                },
              );
            } else {
              return const Center(
                child: AppLoading(),
              );
            }
          },
          future: attractions),
    );
  }
}
