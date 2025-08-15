class ProductsResponseModel {
  final int? id;
  final String? title;
  final double? price;
  final String? description;
  final String? category;
  final String? image;
  final Rating? rating;

  ProductsResponseModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  ProductsResponseModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        title = json['title'] as String?,
        price = (json['price'] as num?)?.toDouble(), // ✅ handles int & double
        description = json['description'] as String?,
        category = json['category'] as String?,
        image = json['image'] as String?,
        rating = (json['rating'] as Map<String, dynamic>?) != null
            ? Rating.fromJson(json['rating'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': category,
        'image': image,
        'rating': rating?.toJson()
      };
}

class Rating {
  final double? rate;
  final int? count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<String, dynamic> json)
      : rate = (json['rate'] as num?)?.toDouble(), // ✅ safe conversion
        count = (json['count'] as num?)?.toInt();

  Map<String, dynamic> toJson() => {
        'rate': rate,
        'count': count,
      };
}
