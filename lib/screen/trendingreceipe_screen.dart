import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'healthyrecipehome_screen.dart';

class TrendingRecipeScreen extends StatefulWidget {
  const TrendingRecipeScreen({super.key});

  @override
  State<TrendingRecipeScreen> createState() => _TrendingRecipeScreenState();
}

class _TrendingRecipeScreenState extends State<TrendingRecipeScreen> {
  late DatabaseReference _recipeRef;
  bool _glutenFree = false;
  bool _highProtein = false;
  bool _vegan = false;
  bool _vegetarian = false;

  @override
  void initState() {
    super.initState();
    _recipeRef = FirebaseDatabase.instance.ref().child('Healthy Recipe');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Recipes',
        textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog(context);
            },
          )
        ],
      ),
      body: StreamBuilder<Map<dynamic, dynamic>>(
        stream: _recipeRef.onValue.map((event) => event.snapshot.value as Map<dynamic, dynamic>),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            Map<dynamic, dynamic> recipes = snapshot.data!;

            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                var recipe = recipes.values.toList()[index];
                var dietaryPreferences = recipe['Dietary Preferences'] ?? {};

                bool showRecipe = true;

                if (_glutenFree && !(dietaryPreferences['Gluten free'] ?? false)) {
                  showRecipe = false;
                }

                if (_highProtein && !(dietaryPreferences['High Protein'] ?? false)) {
                  showRecipe = false;
                }

                if (_vegan && !(dietaryPreferences['Vegan'] ?? false)) {
                  showRecipe = false;
                }

                if (_vegetarian && !(dietaryPreferences['Vegetarian'] ?? false)) {
                  showRecipe = false;
                }

                if (showRecipe) {
                  return ListTile(
                    title: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(recipe['Image URL']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 200,
                          color: Colors.black.withOpacity(0.4),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              recipe['Title'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        recipe['Description'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailScreen(recipe: recipe),
                        ),
                      );
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }


  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text('Filter Options'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildFilterChip('Gluten free', _glutenFree, () {
                    setState(() {
                      _glutenFree = !_glutenFree;
                    });
                  }),
                  _buildFilterChip('High Protein', _highProtein, () {
                    setState(() {
                      _highProtein = !_highProtein;
                    });
                  }),
                  _buildFilterChip('Vegan', _vegan, () {
                    setState(() {
                      _vegan = !_vegan;
                    });
                  }),
                  _buildFilterChip('Vegetarian', _vegetarian, () {
                    setState(() {
                      _vegetarian = !_vegetarian;
                    });
                  }),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Apply',
                  style: TextStyle(
                    color: Colors.blueAccent,
                  )),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildFilterChip(
      String label, bool selected, VoidCallback onPressed) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: FilterChip(
            label: Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black,
              ),
            ),
            selected: selected,
            onSelected: (value) {
              onPressed();
              // Trigger rebuild to apply filters
              setState(() {});
            },
            selectedColor: Colors.blue,
            checkmarkColor: Colors.white,
            backgroundColor: Colors.grey[300],
        ),
        );
    }
}
