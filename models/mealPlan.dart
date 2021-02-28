class MealPlanModel {

  final String uid;
  final String recipeId;
  final int date;

  MealPlanModel({ this.uid, this.recipeId, this.date,});

}

class ActiveDay {
  static int day;
}

class Meals {
  static List meals;
  static List allRecipes;
}