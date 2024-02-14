import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'fetchBottomSheetItems.dart';
import 'getItemIcon.dart';

Future<void> showDataBottomSheetForFood(BuildContext context, {
  required String bottomsheetTitle,
  required String mealTime,
  int? updateQuantity,
  DateTime? updateDate,
  int? updateCalories,
  double? updateProtein,
  double? updateCarbs,
  double? updateFat,
  required Function(String, String, int, int, double, double, double) onSelect,
  required Function() updateData,
  Function(String, String, Map<String, dynamic>)? onDelete,
  Function(int, double, double, double)? onUpdate,
}) async {
    List<Map<String, dynamic>> items = [];

    //fetch all the food items
    await fetchItems('Food').then((value) {
      items = value;
    });

    //get only the data for selected item
    Map<String, dynamic>? itemData = await getItemData(items, bottomsheetTitle);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        String count = '';
        String type = '';
        int calories = 0;
        double protein = 0;
        double carbs = 0;
        double fat = 0;

        if (itemData != null) {
          count = itemData['count'];
          type = itemData['type'];
          calories = itemData['calories'];
          protein = itemData['protein'];
          carbs = itemData['carbs'];
          fat = itemData['fat'];
        } else {
          print('Item not found.');
        }

        int initialCalories = calories;
        double initialProtein = protein;
        double initialCarbs = carbs;
        double initialFat = fat;

        //insert the values to local varible if user is performing update
        if (updateCalories != null){
          calories = updateCalories ?? calories;
          protein = updateProtein ?? protein;
          carbs = updateCarbs ?? carbs;
          fat = updateFat ?? fat;
        }

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          getFoodIcon(type ?? '')[0],
                          size: 30,
                          color: getFoodIcon(type ?? '')[1],
                        ),
                        SizedBox(width: 10),
                        Text(
                          bottomsheetTitle,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      type,
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
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      calories.toString(), style: TextStyle(color: Colors.black)),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.flash_on,
                                        color: Colors.orange,
                                        size: 14,
                                      ),
                                      Text(
                                        'Calories',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            color: Colors.grey[200],
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      protein.toString(), style: TextStyle(color: Colors.black)),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.fitness_center,
                                        color: Colors.green,
                                        size: 14,
                                      ),
                                      Text(
                                        'Protein',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            color: Colors.grey[200],
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      carbs.toString(), style: TextStyle(color: Colors.black)),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.local_pizza,
                                        color: Colors.brown,
                                        size: 14,
                                      ),
                                      Text(
                                        'Carbs',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            color: Colors.grey[200],
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      fat.toString(), style: TextStyle(color: Colors.black)),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.local_gas_station,
                                        color: Colors.red,
                                        size: 14,
                                      ),
                                      Text(
                                        'Fat',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
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
                          border: Border.all(color: Color(0xFF01AAEC)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          //show exisiting quantity if user is updating, else '1'
                          initialValue: updateQuantity != null ? updateQuantity.toString() : '1',
                          onChanged: (value) { //when user enter a quantity
                            if (value.isNotEmpty && int.tryParse(value) != null) {
                              setState(() {
                                quantity = int.parse(value);

                                if(quantity != 0) { //calculate the total gains
                                  int totalCalories = initialCalories * quantity;
                                  double totalProtein = initialProtein * quantity;
                                  double totalCarbs = initialCarbs * quantity;
                                  double totalFat = initialFat * quantity;

                                  calories = totalCalories;
                                  protein = double.parse(totalProtein.toStringAsFixed(2));
                                  carbs = double.parse(totalCarbs.toStringAsFixed(2));
                                  fat = double.parse(totalFat.toStringAsFixed(2));
                                }
                              });
                            }
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
                    Visibility( //if user is adding new item to log
                    visible: updateCalories == null,
                      child: TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          //pass the user selected data
                          await onSelect(bottomsheetTitle, count, quantity, calories, protein, carbs, fat);
                          //call the update method to update the data in database
                          await updateData();
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
                        child:
                          Text(
                          "Add to $mealTime",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Visibility( //if user is updating data
                      visible: updateCalories != null,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () async {
                                //get the gains to be updated in total gains
                                int updatedCalories = calories - (updateCalories ?? 0);
                                double updatedProtein = protein - (updateProtein ?? 0);
                                double updatedCarbs = carbs - (updateCarbs ?? 0);
                                double updatedFat = fat - (updateFat ?? 0);

                                Navigator.pop(context);
                                //pass the updated gains for calculation
                                onUpdate!(updatedCalories, updatedProtein, updatedCarbs, updatedFat);
                                //pass the updated gains for database
                                await onSelect(bottomsheetTitle, count, quantity, calories, protein, carbs, fat);
                                await updateData(); //call update method to update in database
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF284494),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                              child:
                              Text(
                                "Update to $mealTime",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: ()  async {
                            Navigator.pop(context);
                            //delete the item log from database
                            await deleteItem(updateDate!, mealTime, bottomsheetTitle);
                            //pass the deleted gains
                            await onDelete!(bottomsheetTitle, mealTime, {
                              'calories': updateCalories,
                              'protein': updateProtein,
                              'carbs': updateCarbs,
                              'fat': updateFat,
                            });
                            await updateData();
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
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

Future<void> showDataBottomSheetForExercise(BuildContext context, {
  required String bottomsheetTitle,
  DateTime? updateDate,
  String? updateLastDropdownValue,
  int? updateCalories,
  String? updateSessionTime,
  required Function() updateData,
  required Function(String, String, String, int) onSelect,
  Function(String, String, Map<String, dynamic>)? onDelete,
  Function(int)? onUpdate,
}) async {
  List<Map<String, dynamic>> items = [];

  //call the method to fetch all the items from database
  await fetchItems('Exercise').then((value) {
    items = value;
  });

  //get the data for only user selected exercise
  Map<String, dynamic>? itemData = await getItemData(items, bottomsheetTitle);

  String lastDropdownValue = updateLastDropdownValue != null ? updateLastDropdownValue : 'Min';

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      String dropdownValue = lastDropdownValue;
      TextEditingController sessionTime = TextEditingController(text:
      updateSessionTime != null ? updateSessionTime : lastDropdownValue == 'Hrs' ? '1' : '30');

      int calories = 0;

      if (itemData != null) {
        calories = itemData['calories'];
      } else {
        print('Item not found.');
      }

      int initialCalories = calories;
      int initialSessionTime = 30;

      if (updateCalories != null){
        calories = updateCalories ?? calories;
      }

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        getExerciseIcon(bottomsheetTitle)[0],
                        size: 30,
                        color: getExerciseIcon(bottomsheetTitle)[1],
                      ),
                      SizedBox(width: 10),
                      Text(
                        bottomsheetTitle,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
                            border: Border.all(color: Color(0xFF01AAEC)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            controller: sessionTime,
                            onChanged: (value) {
                              int session = int.tryParse(value) ?? 0;
                              double caloriesPerMinute;

                              if (session == 0) {
                                setState(() {
                                  calories = 0;
                                });
                                return;
                              }

                              if (lastDropdownValue == 'Min') {
                                caloriesPerMinute = initialCalories / initialSessionTime;
                              } else {
                                print('inside hrs');
                                session *= 60;
                                caloriesPerMinute = initialCalories / initialSessionTime;
                              }

                              int updatedCalories = (caloriesPerMinute * session).toInt();

                              setState((){
                                calories = updatedCalories;
                                print(calories);
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
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Color(0xFF01AAEC)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                                lastDropdownValue = dropdownValue;

                                if (lastDropdownValue == 'Hrs') {
                                  sessionTime.text = '1';
                                  calories = ((initialCalories / 30) * 60).toInt();
                                } else {
                                  sessionTime.text = '30';
                                  calories = initialCalories;
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
                  Visibility( //if user adding an exercise
                    visible: updateCalories == null,
                    child: TextButton(
                      onPressed: () async {
                        //pass the user selected exercise data
                        await onSelect(bottomsheetTitle, lastDropdownValue, sessionTime.text, calories);
                        await updateData(); //update the user selected data in database
                        Navigator.pop(context);
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
                        "Add to $bottomsheetTitle",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Visibility( //if user updating an exercise
                    visible: updateCalories != null,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () async {
                              int updatedCalories = calories - (updateCalories ?? 0);
                              onUpdate!(updatedCalories); //pass the updated calories
                              //pass the user updated exercise data
                              await onSelect(bottomsheetTitle, lastDropdownValue, sessionTime.text, calories);
                              await updateData(); //update data in database
                              Navigator.pop(context);
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
                              "Update to $bottomsheetTitle",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: ()  async {
                            Navigator.pop(context);
                            //delete the log from database
                            await deleteItem(updateDate!, 'Exercise', bottomsheetTitle);
                            //pass the deleted data
                            await onDelete!(bottomsheetTitle, 'Exercise', {
                              'calories': updateCalories,
                            });
                            await updateData(); //update in database
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Color(0xFF284494),
                          ),
                        ),
                      ],
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