import 'dimensions.dart';
import 'enums/availability_status.dart';
import 'enums/category.dart';
import 'enums/return_policy.dart';
import 'meta.dart';
import 'review.dart';

class Product {
  int id;
  String title;
  String description;
  Category category;
  double price;
  double discountPercentage;
  double rating;
  int stock;
  List<String> tags;
  String? brand;
  String sku;
  int weight;
  Dimensions dimensions;
  String warrantyInformation;
  String shippingInformation;
  AvailabilityStatus availabilityStatus;
  List<Review> reviews;
  ReturnPolicy returnPolicy;
  int minimumOrderQuantity;
  Meta meta;
  List<String> images;
  String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    category: parseCategory(json['category']),
    price: (json['price'] as num).toDouble(),
    discountPercentage: (json['discountPercentage'] as num).toDouble(),
    rating: (json['rating'] as num).toDouble(),
    stock: json['stock'],
    tags: List<String>.from(json['tags']),
    brand: json['brand'],
    sku: json['sku'],
    weight: json['weight'],
    dimensions: Dimensions.fromJson(json['dimensions']),
    warrantyInformation: json['warrantyInformation'],
    shippingInformation: json['shippingInformation'],
    availabilityStatus: parseAvailabilityStatus(json['availabilityStatus']),
    reviews: (json['reviews'] as List)
        .map((item) => Review.fromJson(item))
        .toList(),
    returnPolicy: parseReturnPolicy(json['returnPolicy']),
    minimumOrderQuantity: json['minimumOrderQuantity'],
    meta: Meta.fromJson(json['meta']),
    images: List<String>.from(json['images']),
    thumbnail: json['thumbnail'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'category': category.name,
    'price': price,
    'discountPercentage': discountPercentage,
    'rating': rating,
    'stock': stock,
    'tags': tags,
    'brand': brand,
    'sku': sku,
    'weight': weight,
    'dimensions': dimensions.toJson(),
    'warrantyInformation': warrantyInformation,
    'shippingInformation': shippingInformation,
    'availabilityStatus': availabilityStatusToString(availabilityStatus),
    'reviews': reviews.map((e) => e.toJson()).toList(),
    'returnPolicy': returnPolicyToString(returnPolicy),
    'minimumOrderQuantity': minimumOrderQuantity,
    'meta': meta.toJson(),
    'images': images,
    'thumbnail': thumbnail,
  };
}

AvailabilityStatus parseAvailabilityStatus(String status) {
  switch (status.toLowerCase()) {
    case 'in stock':
      return AvailabilityStatus.inStock;
    case 'out of stock':
      return AvailabilityStatus.outOfStock;
    case 'discontinued':
      return AvailabilityStatus.discontinued;
    case 'low stock':
      return AvailabilityStatus.lowStock;
    default:
      return AvailabilityStatus.inStock;
  }
}

String availabilityStatusToString(AvailabilityStatus status) {
  switch (status) {
    case AvailabilityStatus.inStock:
      return 'In Stock';
    case AvailabilityStatus.outOfStock:
      return 'Out of Stock';
    case AvailabilityStatus.discontinued:
      return 'Discontinued';
    case AvailabilityStatus.lowStock:
      return 'Low Stock';
  }
}

ReturnPolicy parseReturnPolicy(String value) {
  switch (value.toLowerCase()) {
    case 'no return policy':
      return ReturnPolicy.noReturnPolicy;
    case '30 days return policy':
      return ReturnPolicy.the30DaysReturnPolicy;
    case '60 days return policy':
      return ReturnPolicy.the60DaysReturnPolicy;
    case '7 days return policy':
      return ReturnPolicy.the7DaysReturnPolicy;
    case '90 days return policy':
      return ReturnPolicy.the90DaysReturnPolicy;
    default:
      throw ArgumentError('Unknown return policy: $value');
  }
}

String returnPolicyToString(ReturnPolicy policy) {
  switch (policy) {
    case ReturnPolicy.noReturnPolicy:
      return 'No return policy';
    case ReturnPolicy.the30DaysReturnPolicy:
      return '30 days return policy';
    case ReturnPolicy.the60DaysReturnPolicy:
      return '60 days return policy';
    case ReturnPolicy.the7DaysReturnPolicy:
      return '7 days return policy';
    case ReturnPolicy.the90DaysReturnPolicy:
      return '90 days return policy';
  }
}

Category parseCategory(String category) {
  switch (category.toLowerCase()) {
    case 'beauty':
      return Category.beauty;
    case 'fragrances':
      return Category.fragrances;
    case 'furniture':
      return Category.furniture;
    case 'groceries':
      return Category.groceries;
    case 'smartphones':
      return Category.smartphones;
    case 'laptops':
      return Category.laptops;
    case 'home-decoration':
      return Category.homeDecoration;
    case 'skincare':
      return Category.skincare;
    case 'automotive':
      return Category.automotive;
    case 'motorcycle':
      return Category.motorcycle;
    case 'lighting':
      return Category.lighting;
    default:
      print('Unknown category: $category, using beauty as default');
      return Category.beauty;
  }
}
