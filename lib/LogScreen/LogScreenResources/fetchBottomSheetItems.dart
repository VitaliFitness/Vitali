import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Map<String, dynamic>>> fetchItems(String bottomSheetType) async {
  List<Map<String, dynamic>> items = [];

  late DataSnapshot snapshot;
  if (bottomSheetType == "Exercise") {
    snapshot = (await FirebaseDatabase.instance.ref().child('Exercise').get());
    Map<dynamic, dynamic>? data = snapshot.value as Map<dynamic, dynamic>?;
    if (data != null) {
      data.forEach((exerciseKey, exerciseValue) {
        String exerciseName = exerciseKey.toString();
        int calories = exerciseValue['Calories'];

        items.add({'name': exerciseName, 'calories': calories});
      });
    }
  } else {
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

            items.add({'name': name, 'type': type, 'calories': calories, 'count': count, 'protein': protein, 'carbs': carbs, 'fat': fat});
          });
        }
      });
    }
  }

  print(items);
  return items;
}

Map<String, dynamic>? getItemData(List<Map<String, dynamic>> items, String name) {
  for (var item in items) {
    if (item['name'] == name) {
      return item;
    }
  }
  return null;
}

Future<void> deleteItem(DateTime logDate, String mealTime, String itemName) async {
  final prefs = await SharedPreferences.getInstance();
  final email = prefs.getString('Email');

  String date = DateFormat('dd-MM-yyyy').format(logDate);
  final CollectionReference userDataCollection = FirebaseFirestore.instance.collection('User Data');
  final DocumentReference dateDocRef = userDataCollection.doc(email).collection('Dates').doc(date);

  print(dateDocRef);
  try {
    DocumentSnapshot snapshot = await dateDocRef.get();
    if (snapshot.exists) {
      Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;
      if (userData != null) {
        print(mealTime);
        print(itemName);
        String subcollectionName = '';
        switch (mealTime) {
          case 'Breakfast':
            subcollectionName = 'Breakfast log';
            break;
          case 'Lunch':
            subcollectionName = 'Lunch log';
            break;
          case 'Dinner':
            subcollectionName = 'Dinner log';
            break;
          case 'Exercise':
            subcollectionName = 'Exercise log';
            break;
          default:
            throw Exception('Invalid meal time: $mealTime');
        }

        Map<String, dynamic>? items = userData[subcollectionName] as Map<String, dynamic>?;
        if (items != null && items.containsKey(itemName)) {
          await dateDocRef.update({
            '$subcollectionName.$itemName': FieldValue.delete(),
          });
          print('Item $itemName deleted successfully');
        } else {
          print('Item $itemName not found in Breakfast');
        }
      } else {
        print('User data not found');
      }
    } else {
      print('Document not found');
    }
  } catch (error) {
    print('Error deleting item: $error');
  }
}
