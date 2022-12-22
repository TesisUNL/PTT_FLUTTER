import 'dart:async';

import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:flutter/material.dart';
import 'package:ptt_rtmb/core/models/attraction/attraction.dart';
import 'package:ptt_rtmb/core/services/attraction/attraction_service.dart';
import 'package:ptt_rtmb/core/utils/widgets/custom_snackbar.dart';

class MultiSelectList extends StatefulWidget {
  String cantonName = "";
  MultiSelectList(String cantonAttractions) {
    cantonName = cantonAttractions;
  }

  @override
  _MultiSelectListState createState() => new _MultiSelectListState();
}

class _MultiSelectListState extends State<MultiSelectList> {
  late Future<List<Attraction>> attractions;
  Future<List<Attraction>> fetchAttractions(String cantonName) async =>
      await getAttractionsByCantonName(cantonName);

  @override
  void initState() {
    super.initState();
    attractions = fetchAttractions(widget.cantonName);
  }

  final MultiSelectController<String> _controller = MultiSelectController();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<List<Attraction>>(
            future: attractions,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final _items = snapshot.data!;
                return MultiSelectCheckList(
                  maxSelectableCount: 5,
                  textStyles: const MultiSelectTextStyles(
                      selectedTextStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  itemsDecoration: MultiSelectDecorations(
                      selectedDecoration:
                          BoxDecoration(color: Colors.indigo.withOpacity(0.8))),
                  listViewSettings: ListViewSettings(
                      separatorBuilder: (context, index) => const Divider(
                            height: 0,
                          )),
                  controller: _controller,
                  items: List.generate(
                      _items.length,
                      (index) => CheckListCard(
                          value: _items[index].description,
                          title: Text(_items[index].name),
                          subtitle: Text(_items[index].location),
                          selectedColor: Colors.white,
                          checkColor: Colors.indigo,
                          selected: index == 3,
                          enabled: !(index == 5),
                          checkBoxBorderSide:
                              const BorderSide(color: Colors.blue),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)))),
                  onChange: (allSelectedItems, selectedItem) {},
                  onMaximumSelected: (allSelectedItems, selectedItem) {
                    CustomSnackBar.showInSnackBar(
                        'The limit has been reached', context);
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            }));
  }
}
