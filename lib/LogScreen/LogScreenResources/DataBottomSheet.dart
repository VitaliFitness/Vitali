import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

void showDataBottomSheet(BuildContext context, {
  required String bottomsheetTitle,
  required String bottomSheetSubtitile,
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
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(16.0),
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
                    bottomsheetTitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[300],
                      fontWeight: FontWeight.bold,
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
                ],
              ),
            );
          },
        );
      },
    );

}