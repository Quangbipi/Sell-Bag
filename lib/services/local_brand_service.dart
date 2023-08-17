import 'package:hive/hive.dart';
import 'package:hive/hive.dart';

import '../models/category.dart';
class LocalBrandService{
  late Box<Category> _categoryBox;
  late Box<Category> _brandBox;
  LocalBrandService(){
    init();
  }
  Future<void> init() async{
    _categoryBox = await Hive.openBox<Category>('Categories');
    _brandBox = await Hive.openBox<Category>('Brands');
  }

  Future<void> assignAllAdBrands({required List<Category> brands}) async{
    await _categoryBox.clear();
    print("Brand ${brands.toString()}");
    await _categoryBox.addAll(brands);
  }

  Future<void> assignAllBrands({required List<Category> brands}) async{
    await _categoryBox.clear();
    await _categoryBox.addAll(brands);
  }
  List<Category> getCategory() => _categoryBox.values.toList();
  List<Category> getBrand() => _categoryBox.values.toList();
}