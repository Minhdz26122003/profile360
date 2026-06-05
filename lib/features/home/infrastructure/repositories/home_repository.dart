import 'package:democart/features/home/domain/entities/home_data.dart';

abstract class HomeRepository {
  Future<HomeData> loadHome();
}
