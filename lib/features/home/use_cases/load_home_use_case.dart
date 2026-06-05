import 'package:democart/features/home/domain/entities/home_data.dart';
import 'package:democart/features/home/infrastructure/repositories/home_repository.dart';

class LoadHomeUseCase {
  const LoadHomeUseCase(this._repository);

  final HomeRepository _repository;

  Future<HomeData> call() {
    return _repository.loadHome();
  }
}
