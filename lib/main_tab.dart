import 'package:flutter/material.dart';
import 'package:vitali/screens_recipes/healthyrecipehome_screen.dart';

import 'Dashboard/profile_screen.dart';
import 'LogScreen/LogScreen.dart';
import 'ProgressScreen/fitness_progress_screen.dart';


class MainTabView extends StatefulWidget {
  const MainTabView({required Key key, required String userEmail}) : super(key:key);
  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int selectTab = 0;
  final PageStorageBucket pageBucket = PageStorageBucket();
  late Widget currentTab;

  @override
  void initState() {
    super.initState();
    currentTab =  ProfileScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: pageBucket, child: currentTab),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFEAEDF5),
        child: Container(
          color: Colors.white,
          height: kToolbarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.home, color: selectTab == 0 ? const Color(0xFF0C2D57) : Colors.grey),
                  onPressed: () {
                    setState(() {
                      selectTab = 0;
                      currentTab = ProfileScreen();
                    });
                  },
                ),
              ),
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.assignment, color: selectTab == 1 ? const Color(0xFF0C2D57) : Colors.grey),
                  onPressed: () {
                    setState(() {
                      selectTab = 1;
                      currentTab = LogScreen();
                    });
                  },
                ),
              ),
              
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.restaurant_menu_rounded, color: selectTab == 2 ? const Color(0xFF0C2D57) : Colors.grey),
                  onPressed: () {
                    setState(() {
                      selectTab = 2;
                      // Add navigation to camera screen
                      currentTab = const RecipeScreen();
                    });
                  },
                ),
              ),
              
              Expanded(
                child: IconButton(
                  icon: Icon(Icons.trending_up_rounded, color: selectTab == 3 ? const Color(0xFF0C2D57) : Colors.grey),
                  onPressed: () {
                    setState(() {
                      selectTab = 3;
                      currentTab = FitnessProgress(userEmail: '',);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
