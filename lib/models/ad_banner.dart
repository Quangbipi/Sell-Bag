import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'ad_banner.g.dart';

List<AdBanner> adBannerListFromJson(String val) => List<AdBanner>.from(
  json.decode(val)['data'].map((banner) => AdBanner.fromJson(banner))
);

@HiveType(typeId: 0)
class AdBanner extends Equatable{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String image;

  AdBanner({
    required this.id,
    required this.image
  });

  factory AdBanner.fromJson(Map<String, dynamic> data) => AdBanner(
      id: data['id'],
      image: data ['attributes']['image']['data']['attributes']['url']
  );
  @override
  // TODO: implement props
  List<Object?> get props => [id, image];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
    };
  }
}