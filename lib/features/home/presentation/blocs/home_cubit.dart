import 'package:democart/features/home/domain/entities/home_data.dart';
import 'package:democart/features/home/infrastructure/repositories/home_repository_impl.dart';
import 'package:democart/features/home/presentation/blocs/home_state.dart';
import 'package:democart/features/home/use_cases/load_home_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef HomeLoader = Future<HomeData> Function();

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({HomeLoader? loader, LoadHomeUseCase? loadHomeUseCase})
    : _loader =
          loader ??
          (loadHomeUseCase ?? LoadHomeUseCase(HomeRepositoryImpl())).call,
      super(const HomeInitial());

  final HomeLoader _loader;

  Future<void> loadHome() async {
    emit(const HomeLoading());
    try {
      final data = await _loader();
      emit(HomeLoaded(data));
    } catch (_) {
      emit(const HomeError('Không tải được dữ liệu trang chủ'));
    }
  }
}
