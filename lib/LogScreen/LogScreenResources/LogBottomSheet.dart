import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vitali/LogScreen/LogScreenResources/DataBottomSheet.dart';

import 'fetchBottomSheetItems.dart';
import 'getItemIcon.dart';

class LogBottomSheet extends StatefulWidget {
  String bottomsheetTitle;
  String mealTime;
  final Function(String, String, String, int, int, double?, double?, double?) onSelect;
  Function() updateData;

  LogBottomSheet({required this.bottomsheetTitle, required this.mealTime, required this.onSelect, required this.updateData});

  @override
  _LogBottomSheet createState() => _LogBottomSheet();
}

class _LogBottomSheet extends State<LogBottomSheet> {

  List<Map<String, dynamic>> items = [];

  List<Map<String, dynamic>> filteredItems = [];
  bool showFilteredResults = false;

  String selectedFood = 'End';


  @override
  void initState() {
    super.initState();
    fetchItems(widget.bottomsheetTitle).then((value) {
      setState(() {
        items = value;
        filteredItems = List.from(items);
      });
    });
  }

  void updateFilteredItems(String query) {
    setState(() {
      filteredItems = items
          .where((item) =>
          item['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      showFilteredResults = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text( //Bottomsheet Title
                        widget.bottomsheetTitle,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:Text(
                          'Search',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextFormField( //Search textformfield
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Color(0xFF01AAEC)),
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                        onChanged: (value) {
                          updateFilteredItems(value);
                        },
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:Text(
                          'Select',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ListView.builder( //show all the fetched items from database in List
                            shrinkWrap: true,
                            itemCount: showFilteredResults ? filteredItems.length : items.length,
                            itemBuilder: (BuildContext context, int index) {
                              final dynamic item = showFilteredResults ? filteredItems[index] : items[index];
                              final String name = item['name'] ?? '';
                              final String type = item['type'] ?? '';
                              final int calories = item['calories'] ?? 0;
                              final String count = item['count'] ?? '';
                              final double protein = item['protein'] ?? 0.0;
                              final double carbs = item['carbs'] ?? 1;
                              final double fat = item['fat'] ?? 0.0;
                              return ListTile(
                                title: Row(
                                  children: [
                                    if (widget.bottomsheetTitle == 'Food')
                                    Icon(
                                      getFoodIcon(type ?? '')[0],
                                      size: 16,
                                      color: getFoodIcon(type ?? '')[1],
                                    ),

                                    if (widget.bottomsheetTitle == 'Exercise')
                                      Icon(
                                        getExerciseIcon(name ?? '')[0],
                                        size: 16,
                                        color: getExerciseIcon(name ?? '')[1],
                                      ),

                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      type,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () { //if user tap on an item, show item data bottom sheet
                                  setState(() {
                                    showFilteredResults = false;
                                    if (widget.bottomsheetTitle == 'Food') { //if user is logging for food
                                      showDataBottomSheetForFood( //call food item data bottom sheet
                                        context,
                                        bottomsheetTitle: name,
                                        mealTime: widget.mealTime,
                                        onSelect: (item, count, quantity, calories, protein, carb,
                                            fat) {
                                          setState(() {
                                            widget.onSelect(item, type, count, quantity, calories, protein, carbs, fat);
                                          });
                                        },
                                        updateData: widget.updateData,
                                      );
                                    } else{ //if user is logging for exercise
                                      showFilteredResults = false;
                                      showDataBottomSheetForExercise( //call exercise data bottom sheet
                                        context,
                                        bottomsheetTitle: name,
                                        onSelect: (item, count, sessionTime, calories) {
                                          setState(() {
                                            widget.onSelect(item, type, count, int.parse(sessionTime), calories, 0, 0, 0);
                                          });
                                        },
                                        updateData: widget.updateData,
                                      );
                                    }
                                  });
                                },
                              );
                            }),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
      child: Row(
        children: [
          SizedBox(width:  10),
          Icon(Icons.add, color: Color(0xFF01AAEC), size: 32),
          SizedBox(width:  10),
          Text(
            'Log food',
            style: TextStyle(
              color: Colors.grey[500],
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}