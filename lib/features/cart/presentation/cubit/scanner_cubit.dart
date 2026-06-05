import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ScannerState extends Equatable {
  const ScannerState();

  @override
  List<Object?> get props => [];
}

class ScannerInitial extends ScannerState {}

class ScannerSuccess extends ScannerState {
  final String bookingId;

  const ScannerSuccess(this.bookingId);

  @override
  List<Object?> get props => [bookingId];
}

class ScannerCubit extends Cubit<ScannerState> {
  ScannerCubit() : super(ScannerInitial());

  void startScan() {}

  void onScanSuccess(String bookingId) {}

  void resetScanner() {
    emit(ScannerInitial());
  }
}
