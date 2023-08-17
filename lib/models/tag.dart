import 'dart:ffi';
import 'package:hive/hive.dart';
part 'tag.g.dart';

@HiveType(typeId: 3)
class Tag {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final double price;

  Tag({required this.id,
    required this.title,
    required this.price});

  factory Tag.fromJson(Map<String, dynamic> data) => Tag(
      id: data['id'],
      title: data['attributes']['title'],
      price: data['attributes']['price'].toDouble()
  );

  Map toJson()=>{
    'id':id,
    'title': title,
    'price': price
  };
}