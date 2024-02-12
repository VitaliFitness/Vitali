import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'healthyrecipehome_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late DatabaseReference _latestRecipesRef;
  late DatabaseReference _recipeRef;
  final List<Map<dynamic, dynamic>> _latestRecipes = [];
  final List<Map<dynamic, dynamic>> _recipes = [];
  List<Map<dynamic, dynamic>> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _latestRecipesRef = FirebaseDatabase.instance.ref().child('Latest Recipe');
    _recipeRef = FirebaseDatabase.instance.ref().child('Healthy Recipe');
    _fetchLatestRecipes();
    _fetchRecipes();
  }

  void _fetchLatestRecipes() {
    _latestRecipesRef.once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null && snapshot.value is Map) {
        Map<dynamic, dynamic>? latestRecipesMap = snapshot.value as Map<dynamic, dynamic>?;
        if (latestRecipesMap != null) {
          latestRecipesMap.forEach((key, value) {
            setState(() {
              _latestRecipes.add(value);
            });
          });
        }
      }
      return null;
    });
  }

  void _fetchRecipes() {
    _recipeRef.once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null && snapshot.value is Map) {
        Map<dynamic, dynamic>? recipesMap = snapshot.value as Map<dynamic, dynamic>?;
        if (recipesMap != null) {
          recipesMap.forEach((key, value) {
            setState(() {
              _recipes.add(value);
            });
          });
        }
      }
      return null;
    });
  }

  void _search(String query) {
    List<Map<dynamic, dynamic>> results = [];
    for (var recipe in _latestRecipes) {
      if (recipe['Title'].toLowerCase().contains(query.toLowerCase())) {
        results.add(recipe);
      }
    }
    for (var recipe in _recipes) {
      if (recipe['Title'].toLowerCase().contains(query.toLowerCase())) {
        results.add(recipe);
      }
    }
    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search Recipes',
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _searchResults.clear();
                });
              },
            ),
          ),
          onChanged: (value) {
            _search(value);
          },
        ),
      ),
      body: _searchResults.isEmpty
          ? const Center(
          child: Text('No search results found'),
       )
          : ListView.builder(
           itemCount: _searchResults.length,
           itemBuilder: (context, index) {
            var recipe = _searchResults[index];
            return ListTile(
              title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(recipe['Image URL']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  color: Colors.black.withOpacity(0.7), // Background color for title
                  padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0), // Padding for title
                  child: Text(
                    recipe['Title'],
                    style: const TextStyle(
                      color: Colors.white, // Text color for title
                      fontSize: 15, // Font size for title
                      fontWeight: FontWeight.bold, // Font weight for title
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9.0),
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
        },
      ),
    );
  }
}
