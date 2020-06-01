class FoodItem {
  final int calories;
  final List ingredients;
  final List tags;
  final List timeToCook;
  final String name;
  final double price;
  final double rating;

  FoodItem(
      {this.calories,
      this.ingredients,
      this.name,
      this.price,
      this.rating,
      this.tags,
      this.timeToCook});
}
