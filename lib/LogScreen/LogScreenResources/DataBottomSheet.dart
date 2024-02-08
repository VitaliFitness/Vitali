import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void showDataBottomSheetForFood(BuildContext context, {
  required String bottomsheetTitle,
  required String bottomsheetSubtitle,
  required String mealTime,
  required String count,
  required Function(String) onSelect,
  required int calories,
  required double protein,
  required double carbs,
  required double fat
}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        int initialCalories = calories;
        double initialProtein = protein;
        double initialCarbs = carbs;
        double initialFat = fat;

        int quantity = 1;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              reverse: true,
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      bottomsheetTitle,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      bottomsheetSubtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: Text(
                        'Data for ($count)',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            color: Colors.grey[200],
                            child: Text(
                                calories.toString(), style: TextStyle(color: Colors.black)),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 50,
                            color: Colors.grey[200],
                            child: Text(
                                protein.toString(), style: TextStyle(color: Colors.black)),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            color: Colors.grey[200],
                            child: Text(
                                carbs.toString(), style: TextStyle(color: Colors.black)),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            color: Colors.grey[200],
                            child: Text(
                                fat.toString(), style: TextStyle(color: Colors.black)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          initialValue: '1',
                          onChanged: (value) {
                            setState((){
                              quantity = int.parse(value);
                              print(quantity);

                              if(quantity != 0) {
                                int updatedCalories = initialCalories * quantity;
                                double updatedProtein = initialProtein * quantity;
                                double updatedCarbs = initialCarbs * quantity;
                                double updatedFat = initialFat * quantity;

                                calories = updatedCalories;
                                protein = double.parse(updatedProtein.toStringAsFixed(2));
                                carbs = double.parse(updatedCarbs.toStringAsFixed(2));
                                fat = double.parse(updatedFat.toStringAsFixed(2));

                                print(calories);
                              }
                            });
                          },
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ),
                    Center(
                        child: Text(
                            'Quantity', style: TextStyle(color: Colors.black))),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () async {

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF284494),
                        minimumSize: Size(MediaQuery
                            .of(context)
                            .size
                            .width, 50),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                      child: Text(
                        "Add to $mealTime",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

}

void showDataBottomSheetForExercise(BuildContext context, {
  required String bottomsheetTitle,
  required int calories,
  required Function(String) onSelect,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      String dropdownValue = 'Min';
      TextEditingController sessionTime = TextEditingController(text: '30');


      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            reverse: true,
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16.0,
                right: 16.0,
                top: 16.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    bottomsheetTitle,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Duration per session',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 30),
                      Expanded(
                        child:Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            controller: sessionTime,
                            onChanged: (value) {
                              setState((){
                                print(sessionTime);
                                }
                              );
                            },
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                                if (dropdownValue == 'Hrs') {
                                  sessionTime.text = '1';
                                } else {
                                  sessionTime.text = '30';
                                }
                              });
                            },
                            items: <String>['Min', 'Hrs']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            style: TextStyle(color: Colors.black),
                            underline: Container(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Calories per session',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 30),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                              calories.toString(), style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () async {

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF284494),
                      minimumSize: Size(MediaQuery
                          .of(context)
                          .size
                          .width, 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    child: Text(
                      "Add",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      );
    },
  );

}