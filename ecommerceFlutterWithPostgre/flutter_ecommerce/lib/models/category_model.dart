class CategoryModel {
  final String icon, title;

  CategoryModel({required this.icon, required this.title});
}

List<CategoryModel> demo_categories = [
  CategoryModel(
    icon: "assets/icons/dress.svg",
    title: "Dress",
  ),
  CategoryModel(
    icon: "assets/icons/shirt.svg",
    title: "Shirt",
  ),
  CategoryModel(
    icon: "assets/icons/pants.svg",
    title: "Pants",
  ),
  CategoryModel(
    icon: "assets/icons/Tshirt.svg",
    title: "Tshirt",
  ),
];
