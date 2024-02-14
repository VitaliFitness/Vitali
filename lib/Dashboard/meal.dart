class Meal {
  final String mealTime, name, imagePath, kiloCaloriesBurnt, timeTaken;
  final String preparation;
  final List ingredients;

  Meal({
    required this.mealTime,
    required this.name,
    required this.imagePath,
    required this.kiloCaloriesBurnt,
    required this.timeTaken,
    required this.preparation,
    required this.ingredients
  });
}

final meals = [
  Meal(
      mealTime: "BREAKFAST",
      name: "Fruit Granola",
      kiloCaloriesBurnt: "271",
      timeTaken: "15",
      imagePath: "assets/fruit_granola.jpg",
      ingredients: [
        "3 cups rolled oats",
        "1 cup chopped nuts (such as almonds, walnuts, or pecans)",
        "1/2 cup seeds (such as pumpkin seeds or sunflower seeds)",
        "1/2 cup shredded coconut (optional)",
        "1/4 cup honey or maple syrup",
        "1/4 cup coconut oil or vegetable oil",
        "1 teaspoon vanilla extract",
        "1/2 teaspoon ground cinnamon",
        "Pinch of salt",
        "1 cup dried fruit (such as raisins, cranberries, chopped apricots, or chopped dates)"
      ],
      preparation:
      '''Preheat your oven to 300°F (150°C) and line a baking sheet with parchment paper or a silicone baking mat. In a large mixing bowl, combine the rolled oats, chopped nuts, seeds, and shredded coconut (if using).

In a small saucepan, heat the honey or maple syrup, coconut oil, vanilla extract, cinnamon, and salt over low heat until the coconut oil is melted and the ingredients are well combined.

Pour the wet mixture over the dry ingredients in the mixing bowl and stir until everything is evenly coated.

Spread the granola mixture evenly onto the prepared baking sheet. Bake in the preheated oven for 25-30 minutes, stirring halfway through, until the granola is golden brown and crispy.

Remove the granola from the oven and let it cool completely on the baking sheet. Once cooled, stir in the dried fruit.

Store the fruit granola in an airtight container at room temperature for up to 2 weeks.'''),

  Meal(
      mealTime: "LUNCH",
      name: "Keto Salad",
      kiloCaloriesBurnt: "350",
      timeTaken: "45",
      imagePath: "assets/Keto_Chicken_Caesar_Salad.jpg",
      ingredients: [
        "2 boneless, skinless chicken breasts",
        "Salt and pepper to taste",
        "1 tablespoon olive oil",
        "1 head of romaine lettuce, chopped",
        "1/2 cup grated Parmesan cheese",
        "Caesar dressing (you can use store-bought or make your own with olive oil, anchovy paste, garlic, Dijon mustard, Worcestershire sauce, lemon juice, and Parmesan cheese)",
        "Optional toppings: cherry tomatoes, sliced avocado, cooked bacon bit"
      ],
      preparation:
      '''Season the chicken breasts with salt and pepper on both sides.

Heat the olive oil in a skillet over medium-high heat. Add the chicken breasts and cook for 6-7 minutes on each side, or until cooked through and golden brown. Remove from the skillet and let them rest for a few minutes before slicing.

While the chicken is cooking, prepare the romaine lettuce by washing and chopping it into bite-sized pieces. Place the chopped lettuce in a large salad bowl.

Add the grated Parmesan cheese to the bowl with the lettuce. Once the chicken has rested, slice it into thin strips or cubes.

Add the sliced chicken to the salad bowl. Drizzle Caesar dressing over the salad, tossing gently to coat the lettuce and chicken evenly.

Optional: Add cherry tomatoes, sliced avocado, and cooked bacon bits on top of the salad for extra flavor and texture.

Serve the Keto Chicken Caesar Salad immediately, and enjoy a delicious and nutritious lunch!'''),

  Meal(
      mealTime: "DINNER",
      name: "Pesto Pasta",
      kiloCaloriesBurnt: "612",
      timeTaken: "15",
      imagePath: "assets/pesto_pasta.jpg",
      ingredients: [
        "12 ounces (340g) of pasta (such as spaghetti, linguine, or penne)",
        "2 cups packed fresh basil leaves",
        "1/2 cup grated Parmesan cheese",
        "1/2 cup pine nuts or walnuts",
        "3 garlic cloves, peeled",
        "1/2 cup extra virgin olive oil",
        "Salt and pepper to taste",
        "Optional: cherry tomatoes, sliced chicken breast, or grilled vegetables for garnish"
      ],
      preparation:
      '''Bring a large pot of salted water to a boil. Cook the pasta according to the package instructions until al dente.

While the pasta is cooking, prepare the pesto sauce. In a food processor, combine the basil leaves, grated Parmesan cheese, pine nuts or walnuts, and garlic cloves. Pulse until the ingredients are finely chopped. With the food processor running, gradually add the olive oil in a steady stream until the pesto is smooth and well combined.

Season the pesto with salt and pepper to taste.

Once the pasta is cooked, drain it well, reserving about 1/2 cup of the pasta cooking water.

In a large serving bowl, toss the cooked pasta with the pesto sauce, adding a little bit of the reserved pasta cooking water if needed to loosen the sauce and help it coat the pasta evenly.

Optional: Garnish the pesto pasta with halved cherry tomatoes, sliced chicken breast, or grilled vegetables for extra flavor and texture.

Serve the pesto pasta immediately, garnished with additional grated Parmesan cheese and fresh basil leaves if desired.
      '''),

  Meal(
      mealTime: "SNACK",
      name: "Keto Snack",
      kiloCaloriesBurnt: "414",
      timeTaken: "16",
      imagePath: "assets/keto_snack.jpg",
      ingredients: [
        "1 cup shredded cheese (such as cheddar, mozzarella, or Parmesan)",
        "Optional: spices or herbs (such as paprika, garlic powder, or dried herbs) for extra flavor"
      ],
      preparation:
      '''Preheat your oven to 375°F (190°C). Line a baking sheet with parchment paper or a silicone baking mat.
      
Place small piles (about 1 tablespoon each) of shredded cheese onto the prepared baking sheet, leaving space between them as they will spread out while baking.

If desired, sprinkle each pile of cheese with a pinch of your chosen spices or herbs for added flavor.

Bake in the preheated oven for 5-7 minutes, or until the cheese crisps are golden brown and crispy around the edges. Remove the baking sheet from the oven and let the cheese crisps cool for a few minutes on the pan.

Once cooled and crispy, carefully transfer the cheese crisps to a plate or wire rack to cool completely and finish crisping up.

Repeat the process with any remaining cheese, if desired. Enjoy your keto cheese crisps as a crunchy and satisfying snack on their own, or pair them with dips like guacamole, salsa, or sour cream.'''),
];

