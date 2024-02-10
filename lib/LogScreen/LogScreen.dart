import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'LogScreenResources/LogBottomSheet.dart';
import 'LogScreenResources/PercentIndicator.dart';

class LogScreen extends StatefulWidget {
  static const String id = "addtraindetails-screen";

  @override
  _LogScreenState createState() => _LogScreenState();
}


class _LogScreenState extends State<LogScreen> {

  DateTime logDate = DateTime.now();

  List<String> breakfastItems = [];
  List<String> lunchItems = [];
  List<String> dinnerItems = [];
  List<String> exercises = [];

  double totalCalories = 0;
  double totalProtein = 0;
  double totalCarbs = 0;
  double totalFat = 0;

  AddSchedule() async {

    final firestore = FirebaseFirestore.instance.collection('Users');

    firestore.doc('email').set({
      'Date' : logDate,
      'Breakfast log' : breakfastItems,
      'Lunch log': lunchItems,
      'Dinner log': dinnerItems,
      'Exercise log': exercises,
      'Calories': totalCalories,
      'Protein': totalProtein,
      'Carbs': totalCarbs,
      'Fat': totalFat,
    }).then((value){
      print('Successfully Added');
      Navigator.pop(context);
    }).onError((error, stackTrace){
      print((error, stackTrace));
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Row(
              children: [
                Text(
                  DateFormat('E dd').format(logDate),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Color(0xFF284494),
        ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          color: Colors.grey[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              showPercentIndicator(
                  caloriesPercentage: _calculatePercentage(totalCalories, 1500),
                  proteinPercentage: _calculatePercentage(totalProtein, 100),
                  carbsPercentage: _calculatePercentage(totalCarbs, 200),
                  fatPercentage: _calculatePercentage(totalFat, 50),
                  currentCalories: totalCalories,
                  currentProtein: totalProtein,
                  currentCarbs: totalCarbs,
                  currentFat: totalFat,
              ),
              SizedBox(height: 30),
              buildItemSection('Breakfast', breakfastItems, (selectedItem, percentages) {
                setState(() {
                  breakfastItems.add(selectedItem);
                  _updateTotals(percentages);
                });
              }),
              buildItemSection('Lunch', lunchItems, (selectedItem, percentages) {
                setState(() {
                  lunchItems.add(selectedItem);
                  _updateTotals(percentages);
                });
              }),
              buildItemSection('Dinner', dinnerItems, (selectedItem, percentages) {
                setState(() {
                  dinnerItems.add(selectedItem);
                  _updateTotals(percentages);
                });
              }),
              buildItemSection('Exercise', exercises, (selectedItem, percentages) {
                setState(() {
                  exercises.add(selectedItem);
                  _updateTotals(percentages);
                });
              }),
            ]
          )
        ),
      )
    );
  }

  Widget buildItemSection(String title, List<String> items, Function(String, Map<String, dynamic>) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        Divider(),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(items[index]),
            );
          },
        ),
        SizedBox(height:10),
        LogBottomSheet(
          bottomsheetTitle: title == 'Exercise' ? 'Exercise' : 'Food',
          mealTime: title,
          onSelect: (item, calories, protein, carb, fat){
            onSelect(item, {
              'calories': calories,
              'protein': protein ?? 0,
              'carbs': carb ?? 0,
              'fat': fat ?? 0,
            });
          },
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: logDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != logDate) {
      setState(() {
        logDate = picked;
      });
    }
  }

  void _updateTotals(Map<String, dynamic> percentages) {
    setState(() {
      totalCalories += percentages['calories'] ?? 0.0;
      totalProtein += percentages['protein'] ?? 0.0;
      totalCarbs += percentages['carbs'] ?? 0.0;
      totalFat += percentages['fat'] ?? 0.0;
    });
  }

  double _calculatePercentage(double value, double target) {
    if (value <= 0) {
      return 0.0;
    } else if (value >= target) {
      return 1.0;
    } else {
      return value / target;
    }
  }
}