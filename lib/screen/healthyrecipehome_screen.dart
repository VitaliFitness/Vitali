import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:vitali/screen/latestreceipe_screen.dart';
import 'package:vitali/screen/search_screen.dart';
import 'package:vitali/screen/trendingreceipe_screen.dart';


class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  late DatabaseReference _recipeRef;
  late DatabaseReference _latestRecipesRef;

  @override
  void initState() {
    super.initState();
    // Initialize Firebase app if not already initialized
    Firebase.initializeApp();
    _recipeRef = FirebaseDatabase.instance.ref().child('Healthy Recipe');
    _latestRecipesRef = FirebaseDatabase.instance.ref().child('Latest Recipe');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Healthy Recipes',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            );
          },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Latest Recipes',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LatestRecipeScreen()),
                    );
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder<Map<dynamic, dynamic>>(
            stream: _latestRecipesRef.onValue.map((event) =>
            event.snapshot.value as Map<dynamic, dynamic>),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final latestRecipesMap = snapshot.data!;
                final latestRecipes = latestRecipesMap.values.toList();
                return CarouselSlider.builder(
                  itemCount: latestRecipes.length > 3 ? 3 : latestRecipes.length,
                  itemBuilder: (BuildContext context, int index,
                      int realIndex) {
                    var recipe = latestRecipes[index];
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RecipeDetailScreen(recipe: recipe),
                            )
                        );
                      },
                      child: RecipeCarouselItem(recipe: recipe,),
                    );
                  },
                  options: CarouselOptions(
                    height: 150.0,
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 5,),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Trending Recipes',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TrendingRecipeScreen()),
                    );
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<Map<dynamic, dynamic>>(
              stream: _recipeRef.onValue.map((event) =>
              event.snapshot.value as Map<dynamic, dynamic>),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final recipesMap = snapshot.data!;
                  final recipes = recipesMap.values.toList();
                  return ListView.builder(
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      var recipe = recipes[index];
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
                              color: Colors.black.withOpacity(0.2), // Adjust opacity as needed
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
                            maxLines: 3,
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
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}



class RecipeCarouselItem extends StatelessWidget {
  final Map<dynamic, dynamic> recipe;

  const RecipeCarouselItem({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[300],
      ),
      child: Stack(
        children: [
          Image.network(
            recipe['Image URL'],
            height: 200.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.black54,
              child: Text(
                recipe['Title'],
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RecipeDetailScreen extends StatelessWidget {
  final Map<dynamic, dynamic> recipe;

  const RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['Title'] ?? 'Recipe Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(recipe['Image URL'] ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Description'),
                  const SizedBox(height: 10),
                  _buildDescription(recipe['Description']),
                  SizedBox(height: 24),
                  _buildSectionTitle('Ingredients'),
                  const SizedBox(height: 10),
                  _buildIngredientsList(recipe['Ingredients']),
                  SizedBox(height: 16),
                  _buildSectionTitle('Instructions'),
                  const SizedBox(height: 10),
                  _buildInstructionsList(recipe['Instructions']),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }

  Widget _buildDescription(String? description) {
    return Text(
      description ?? 'No description available',
      style: TextStyle(
        fontSize: 16,
      ),
    );
  }

  Widget _buildIngredientsList(Map<dynamic, dynamic>? ingredients) {
    if (ingredients != null && ingredients.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: ingredients.entries.map<Widget>((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 16, // Reduced icon size
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.key.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15, // Reduced font size
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              entry.value.toString(),
                              style: TextStyle(
                                fontSize: 13, // Reduced font size
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      );
    } else {
      return Text(
        'No ingredients available',
        style: TextStyle(
          fontStyle: FontStyle.italic,
        ),
      );
    }
  }

  Widget _buildInstructionsList(List<dynamic>? instructions) {
    if (instructions != null && instructions.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: instructions.where((item) => item != null).map<Widget>((item) {
          return Text(
            item.toString(),
            style: TextStyle(
              fontSize: 16,
            ),
          );
        }).toList(),
      );
    } else {
      return Text(
        'No instructions available',
        style: TextStyle(
          fontStyle: FontStyle.italic,
        ),
      );
    }
  }
}