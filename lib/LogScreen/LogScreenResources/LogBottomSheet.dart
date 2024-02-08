import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vitali/LogScreen/LogScreenResources/DataBottomSheet.dart';

class LogBottomSheet extends StatefulWidget {
  String bottomsheetTitle;
  String mealTime;
  String selectedItem;
  final Function(String) onSelect;

  LogBottomSheet({required this.bottomsheetTitle, required this.mealTime, required this.selectedItem, required this.onSelect});

  @override
  _LogBottomSheet createState() => _LogBottomSheet();
}

class _LogBottomSheet extends State<LogBottomSheet> {

  List<Map<String, dynamic>> items = [];

  List<Map<String, dynamic>> filteredItems = [];
  bool showFilteredResults = false;

  String selectedFood = 'End';

  void fetchFoodItems() async {
    late DataSnapshot snapshot;
    if (widget.bottomsheetTitle == "Exercise"){
      snapshot = (await FirebaseDatabase.instance.ref().child('Exercise').get());
      Map<dynamic, dynamic>? data = snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        data.forEach((exerciseKey, exerciseValue) {

          String exerciseName = exerciseKey.toString();
          int calories = exerciseValue['Calories'];

          items.add({'name': exerciseName, 'calories': calories});
        });
      }
        print(items);
        filteredItems = List.from(items);
        setState(() {});

    } else{
      snapshot = (await FirebaseDatabase.instance.ref().child('Food Items').get());
      Map<dynamic, dynamic>? data = snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        data.forEach((categoryKey, categoryValue) {
          if (categoryValue is Map<dynamic, dynamic>) {
            categoryValue.forEach((foodKey, foodValue) {
              String type = categoryKey.toString();
              String name = foodKey.toString();
              int calories = foodValue['Calories'];
              String count = foodValue['Count'].toString();
              double protein = (foodValue['Protein'] ?? 0.0).toDouble();
              double carbs = (foodValue['Carbs'] ?? 0.0).toDouble();
              double fat = (foodValue['Fat'] ?? 0.0).toDouble();
              print(carbs);

              items.add({'name': name, 'type': type, 'calories': calories, 'count': count,
                'protein': protein, 'carbs': carbs, 'fat': fat,});
            });
          }
        });
        print(items);
        filteredItems = List.from(items);
        setState(() {});
    }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFoodItems();
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
              builder: (BuildContext context, StateSetter setState) { //Use StatefulBuilder here
                return Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        widget.bottomsheetTitle,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:Text(
                          'Search Food',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                          border: InputBorder.none,
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                        onChanged: (value) {
                          updateFilteredItems(value);
                        },
                      ),
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:Text(
                          'Select Food',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: ListView.builder(
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
                                onTap: () {
                                  setState(() {
                                    //widget.onSelect(item);
                                    showFilteredResults = false;
                                    Navigator.pop(context);
                                    if (widget.bottomsheetTitle == 'Food') {
                                      showDataBottomSheetForFood(
                                        context,
                                        bottomsheetTitle: name,
                                        bottomsheetSubtitle: type,
                                        mealTime: widget.mealTime,
                                        count: count,
                                        calories: calories,
                                        protein: protein,
                                        carbs: carbs,
                                        fat: fat,
                                        onSelect: (station) {
                                          setState(() {
                                            selectedFood = station;
                                          });
                                        },
                                      );
                                    } else{
                                      print(calories);
                                      showDataBottomSheetForExercise(
                                        context,
                                        bottomsheetTitle: name,
                                        calories: calories,
                                        onSelect: (station) {
                                          setState(() {
                                            selectedFood = station;
                                          });
                                        },
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