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

  String selectedFood = 'End';

  AddSchedule() async {

    final DatabaseReference _dbReference = FirebaseDatabase.instance.ref().child('Train Schedule');
    DatabaseReference scheduleRef = _dbReference.child('01');

    //Add the values in the TextFormField into the 'Train Schedule' database
    scheduleRef.set({
      'Start Station': 'Colombo',
      'End Station': 'Kandy',
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
                  percentage: 20, indicatorName: "Pending"),
              SizedBox(height: 20),
              Text(
                'Breakfast',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              Divider(),
              LogBottomSheet(
                bottomsheetTitle: 'Food',
                mealTime: "Breakfast",
                selectedItem: selectedFood,
                onSelect: (station) {
                  setState(() {
                    selectedFood = station;
                  });
                },
              ),
              SizedBox(height: 20),
              Text(
                'Lunch',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              Divider(),
              LogBottomSheet(
                bottomsheetTitle: 'Food',
                mealTime: "Lunch",
                selectedItem: selectedFood,
                onSelect: (station) {
                  setState(() {
                    selectedFood = station;
                  });
                },
              ),
              SizedBox(height: 20),
              Text(
                'Dinner',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              Divider(),
              LogBottomSheet(
                bottomsheetTitle: 'Food',
                mealTime: "Dinner",
                selectedItem: selectedFood,
                onSelect: (station) {
                  setState(() {
                    selectedFood = station;
                  });
                },
              ),
              SizedBox(height: 20),
              Text(
                'Exercise',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              Divider(),
              LogBottomSheet(
                bottomsheetTitle: 'Exercise',
                mealTime: "Dinner",
                selectedItem: selectedFood,
                onSelect: (station) {
                  setState(() {
                    selectedFood = station;
                  });
                },
              ),
              SizedBox(height: 20),
            ]
          )
        ),
      )
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
}