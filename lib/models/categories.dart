class Categories {
  final int? id;
  final String? name;
  final String? desc;

  Categories({
    this.id,
    this.name,
    this.desc,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json["id"] as int?,
      name: json["name"] as String?,
      desc: json["desc"] as String?
    );
  }
}

/**
 * 
 * {
 *  "id": 1,
 *  "name": "Food",
 *  "desc": "Consumables"
 * },
 * {
 *  "id": 2,
 *  "name": "Drinks",
 *  "desc" : "Drinkables"
 * }
 * 
 */
