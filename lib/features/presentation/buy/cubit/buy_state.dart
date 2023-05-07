import 'package:keepcode/features/data/models/buy_error_mode.dart';
import 'package:keepcode/features/data/models/buy_model.dart';

abstract class BuyState {}

class BuyInit extends BuyState {}

class BuyLoading extends BuyState {}

class BuyLoaded extends BuyState {
  BuyLoaded({required this.buyModel, required this.activation});
  final BuyModel buyModel;
  final List<String> activation;
}

class BuyError extends BuyState {
  BuyError({required this.buyErrorModel});
  final BuyErrorModel buyErrorModel;
}

class BuyNumberIsBusy extends BuyState {}
